(cl:in-package #:cleavir-cst-to-ast)

;;; VAR-AST and SUPPLIED-P-AST are LEXICAL-ASTs that will be set by
;;; the implementation-specific argument-parsing code, according to
;;; what arguments were given.  VALUE-AST is an AST that computes the
;;; initialization for the variable to be used when no explicit value
;;; is supplied by the caller.  This function generates the code for
;;; testing whether SUPPLIED-P-AST computes NIL or T, and for
;;; assigning the value computed by VALUE-AST to VAR-AST if
;;; SUPPLIED-P-AST computes NIL.
(defun make-initialization-ast (client var-ast supplied-p-ast value-ast lexical-environment dynamic-environment-ast)
  (let ((nil-cst (cst:cst-from-expression nil)))
    (make-instance 'cleavir-ast:if-ast
     :test-ast (make-instance 'cleavir-ast:eq-ast
                :arg1-ast supplied-p-ast
                :arg2-ast (convert-constant client nil-cst lexical-environment dynamic-environment-ast)
                :dynamic-environment-ast dynamic-environment-ast)
     :then-ast (make-instance 'cleavir-ast:setq-ast
                 :lhs-ast var-ast
                 :value-ast value-ast
                 :dynamic-environment-ast dynamic-environment-ast)
     :else-ast (convert-constant client nil-cst lexical-environment dynamic-environment-ast)
     :dynamic-environment-ast dynamic-environment-ast)))

;;; VAR-CST and SUPPLIED-P-CST are CSTs representing a parameter
;;; variable and its associated SUPPLIED-P variable. If no associated
;;; SUPPLIED-P variable is present in the lambda list then
;;; SUPPLIED-P-CST is NIL.  INIT-AST is the AST that computes the
;;; value to be assigned to the variable represented by VAR-CST if no
;;; argument was supplied for it.  LEXICAL-ENVIRONMENT is an environment that already
;;; contains the variables corresponding to VAR-CST and SUPPLIED-P-CST
;;; (if it is not NIL).
;;;
;;; This function returns two values.  The first value is an AST that
;;; represents both the processing of this parameter AND the
;;; computation that follows.  We can not return an AST only for this
;;; computation, because if either one of the variables represented by
;;; VAR-CST or SUPPLIED-P-CST is special, then NEXT-AST must be in the
;;; body of a BIND-AST generated by this function.  The second return
;;; value is a list of two LEXICAL-ASTs.  The first lexical AST
;;; corresponds to VAR-CST and the second to SUPPLIED-P-CST.  The
;;; implementation-specific argument-parsing code is responsible for
;;; assigning to those LEXICAL-ASTs according to what arguments were
;;; given to the function.
(defun process-init-parameter
    (client var-cst var-ast supplied-p-cst supplied-p-ast init-ast lexical-environment dynamic-environment-ast next-thunk)
  (process-progn
   (list (make-initialization-ast client var-ast supplied-p-ast init-ast lexical-environment dynamic-environment-ast)
         (set-or-bind-variable
          client
          var-cst var-ast
          (if (null supplied-p-cst)
              next-thunk
              (lambda ()
                (set-or-bind-variable
                 client
                 supplied-p-cst supplied-p-ast
                 next-thunk lexical-environment dynamic-environment-ast)))
          lexical-environment
          dynamic-environment-ast))))