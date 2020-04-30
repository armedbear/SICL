(cl:in-package #:sicl-boot-phase-5)

(defun boot (boot)
  (format *trace-output* "Start of phase 5~%")
  (with-accessors ((e4 sicl-boot:e4)
                   (e5 sicl-boot:e5))
      boot
    (change-class e5 'environment)
    (import-from-host boot)
    (enable-class-finalization boot)
    (finalize-all-classes boot)
    (enable-defmethod boot)
    (enable-allocate-instance e4)
    (enable-object-initialization boot)
    (load-fasl "Conditionals/macros.fasl" e4)
    (sicl-boot:enable-method-combinations #'load-fasl e4 e5)
    (enable-generic-function-invocation boot)
    (define-accessor-generic-functions boot)
    (enable-class-initialization boot)
    (create-mop-classes boot)
    (load-fasl "CLOS/satiation.fasl" e5)))
