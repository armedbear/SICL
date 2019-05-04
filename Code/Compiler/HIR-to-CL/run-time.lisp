(cl:in-package #:sicl-hir-to-cl)

;;; Most of the code in this file should be moved to the boot system
;;; once everything is working.

(defgeneric static-environment (function))

(defclass funcallable-standard-class (closer-mop:funcallable-standard-class)
  ((%code :initarg :code :reader code)
   (%static-environment :initarg :static-environment :reader static-environment)))

(defun enclose (code &rest static-environment-values)
  (make-instance 'funcallable-standard-class
    :code code
    :static-environment
    (coerce (list* nil #'static-environment static-environment-values)
            'vector)))