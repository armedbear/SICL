(cl:in-package #:asdf-user)

(defsystem :cleavir2-mir
  :depends-on (:cleavir2-ir)
  :serial t
  :components
  ((:file "utilities")
   (:file "data")
   (:file "memory-access-instructions")
   (:file "general")
   (:file "conditions")))
