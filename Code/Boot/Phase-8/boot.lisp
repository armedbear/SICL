(cl:in-package #:sicl-boot-phase-8)

(defun boot (boot)
  (format *trace-output* "Start of phase 8~%")
  (with-accessors ((e5 sicl-boot:e5))
      boot
    (load-source "Types/Typep/typep.lisp" e5)
    (load-source "Types/Typep/typep-atomic.lisp" e5)
    (load-source "Types/Typep/typep-compound.lisp" e5)
    (load-source "Types/Typep/typep-compound-integer.lisp" e5)
    (load-source "Arithmetic/less-defun.lisp" e5)
    (load-source "Arithmetic/less-or-equal-defun.lisp" e5)
    (load-source "Arithmetic/equal-defun.lisp" e5)
    (load-source "Arithmetic/not-equal-defun.lisp" e5)
    (load-source "Arithmetic/minus-defun.lisp" e5)
    (load-source "Arithmetic/one-plus-defun.lisp" e5)
    (load-source "Arithmetic/one-minus-defun.lisp" e5)
    (load-source "Arithmetic/zerop-defun.lisp" e5)
    (import-function-from-host 'sicl-genv:type-expander e5)
    (load-source "Conditionals/support.lisp" e5)
    (load-source "Cons/null-defun.lisp" e5)
    (load-source "Cons/listp-defun.lisp" e5)
    (load-source "Cons/list-defun.lisp" e5)
    (load-source "Cons/list-star-defun.lisp" e5)
    (load-source "Cons/set-difference-defun.lisp" e5)
    (load-source "Cons/nset-difference-defun.lisp" e5)
    (load-source "Cons/adjoin-defun.lisp" e5)
    (load-source "Cons/append-defun.lisp" e5)
    (load-source "Cons/nth-defun.lisp" e5)
    (load-source "Cons/nthcdr-defun.lisp" e5)
    (load-source "Cons/copy-list-defun.lisp" e5)
    (import-function-from-host 'cleavir-code-utilities:parse-macro e5)
    (load-source "Cons/with-alist-elements-defmacro.lisp" e5)
    (load-source "Cons/assoc-defun.lisp" e5)
    (load-source "Cons/make-list-defun.lisp" e5)
    (load-source "Cons/last-defun.lisp" e5)
    (load-source "Cons/butlast-defun.lisp" e5)
    (load-source "Cons/union-defun.lisp" e5)
    (load-source "Cons/set-exclusive-or-defun.lisp" e5)
    (load-source "Cons/mapcar-defun.lisp" e5)
    (load-source "Cons/mapc-defun.lisp" e5)
    (load-source "Cons/mapcan-defun.lisp" e5)
    (load-source "Cons/mapcon-defun.lisp" e5)))
