(cl:in-package #:common-lisp-user)

(defpackage #:sicl-hir-to-mir
  (:use #:common-lisp)
  (:export #:hir-to-mir
           #:entry-point-input
           #:enter-instruction))
