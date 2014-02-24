(cl:in-package #:common-lisp-user)

(asdf:defsystem :sicl-clos-phase2
  :depends-on (:sicl-clos-phase1)
  ;; We use :SERIAL T so as to reduce the clutter with respect to the
  ;; dependencies, and to make the order completely predictable.
  :serial t
  :components
  (;; In the machinery for making it possible to execute generic
   ;; functions, there are some non-trivial computations needed, such
   ;; as sorting and operations on lists.  However, some of the
   ;; standard Common Lisp functions that are needed in those
   ;; computations might be defined as generic functions in some
   ;; implementations, in particular in SICL.  In order to avoid
   ;; invoking generic functions in order to invoke generic functions,
   ;; we define special, non-generic versions of these functions and
   ;; we make them less general so that they work only on lists. 
   (:file "list-utilities")
   ;; The symbol MAKE-INSTANCE is shadowed in the SICL-CLOS package,
   ;; but now, we need for MAKE-INSTANCE to do the same thing as
   ;; CL:MAKE-INSTANCE, so we define SICL-CLOS as a function that just
   ;; calls CL:MAKE-INSTANCE.
   (:file "make-instance")
   ;; The symbol COMPILE is shadowed in the SICL-CLOS package, but
   ;; now, we need for COMPILE to do the same thing as CL:COMPILE, so
   ;; we define SICL-CLOS as a function that just calls CL:COMPILE.
   (:file "compile")
   ;; The symbols INITIALIZE-INSTANCE, REINITIALIZE-INSTANCE, and
   ;; SHARED-INITIALIZED are shadowed in the SICL-CLOS package.  But
   ;; we still need for the methods on INITIALIZE-INSTANCE defined
   ;; here to be called as methods on CL:INITIALIZE-INSTANCE.  We
   ;; solve this problem by setting the fdefinition of the symbol
   ;; SICL-CLOS:INITIALIZE-INSTANCE to the fdefinition of the function
   ;; CL:INITIALIZE-INSTANCE.
   (:file "initialize-instance")
   ;; Define host generic functions for the other initialization
   ;; functions.
   (:file "reinitialize-instance-defgenerics")
   (:file "shared-initialize-defgenerics")
   ;; Although we do not use the dependent maintenance facility, we
   ;; define the specified functions as ordinary functions that do
   ;; nothing, so that we can safely call them from other code.
   (:file "dependent-maintenance-support")
   (:file "dependent-maintenance-defuns")
   ;; The symbol FIND-CLASS is shadowed in the SICL-CLOS package, but
   ;; now, we need for FIND-CLASS to do the same thing as
   ;; CL:FIND-CLASS, so we define SICL-CLOS as a function that just
   ;; calls CL:FIND-CLASS.
   (:file "find-class")
   ;; Define the specified ordinary function
   ;; SET-FUNCALLABLE-INSTANCE-FUNCTION to set the discriminating
   ;; function of the bridge generic function. 
   (:file "set-funcallable-instance-function")
   ;; Define :AFTER methods on INITIALIZE-INSTANCE that implement the
   ;; generic function initialization protocol
   (:file "generic-function-initialization-support")
   (:file "generic-function-initialization-defmethods")
   (:file "bridge-generic-function")
   (:file "generic-function-database")
   (:file "fmakunbound-defgeneric")
   (:file "defgeneric-defmacro")
   (:file "specializerp")
   (:file "method-initialization-support")
   (:file "method-initialization-defmethods")
   (:file "ensure-generic-function")
   (:file "slot-value")
   (:file "add-remove-direct-method-support")
   (:file "add-remove-direct-method-defuns")
   (:file "class-of")
   (:file "compute-applicable-methods-support")
   (:file "compute-applicable-methods-defuns")
   (:file "reader-writer-method-classes")
   (:file "compute-effective-method-support")
   (:file "compute-effective-method-support-a")
   (:file "compute-effective-method-defuns")
   (:file "find-class-named-t")
   (:file "no-applicable-method-defuns")
   (:file "discriminating-automaton")
   (:file "discriminating-tagbody")
   (:file "compute-discriminating-function-support")
   (:file "compute-discriminating-function-support-a")
   (:file "compute-discriminating-function-defuns")
   (:file "accessor-defgenerics")
   (:file "add-remove-method-support")
   (:file "add-remove-method-defuns")
   (:file "class-database")
   (:file "reader-writer-method-class-support")
   (:file "reader-writer-method-class-defuns")
   (:file "make-accessor-method-a")
   (:file "add-accessor-method")
   (:file "slot-definition-classes")
   (:file "slot-definition-class-support")
   (:file "slot-definition-class-defuns")
   (:file "classp")
   (:file "functionp")
   (:file "direct-slot-definition-p")
   (:file "standard-object-classes")
   (:file "validate-superclass")
   (:file "class-initialization-support")
   (:file "class-initialization-defmethods")
   (:file "fmakunbound-define-built-in-class")
   (:file "fmakunbound-defclass")
   (:file "class-finalization-support")
   (:file "class-finalization-defuns")
   (:file "built-in-class-finalization")
   (:file "ensure-built-in-class")
   (:file "ensure-class")
   (:file "defclass-support")
   (:file "defclass-defmacro")
   (:file "define-built-in-class-defmacro")
   (:file "make-method-lambda-support")
   (:file "make-method-lambda-defuns")
   (:file "defmethod-support")
   (:file "fmakunbound-defmethod")
   (:file "ensure-method")
   (:file "defmethod-defmacro")
   (:file "mop-class-hierarchy")
   (:file "additional-classes")
   ))
