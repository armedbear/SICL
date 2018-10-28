(cl:in-package #:sicl-new-boot-inspector)

(defun define-methods-on-inspec-object (boot)
  (with-accessors ((e1 sicl-new-boot:e1)
                   (e2 sicl-new-boot:e2)
                   (e3 sicl-new-boot:e3)
                   (e4 sicl-new-boot:e4)) boot
    (defmethod clouseau:inspect-object
        ((object sicl-new-boot-phase-2::header) pane)
      (let ((class (slot-value object 'sicl-new-boot-phase-2::%class))
            (rack (slot-value object 'sicl-new-boot-phase-2::%rack))
            (name-fun (sicl-genv:fdefinition 'sicl-clos:slot-definition-name e2))
            (location-fun (sicl-genv:fdefinition 'sicl-clos:slot-definition-location e2)))
        (clim:formatting-table (pane)
          (clim:formatting-row (pane)
            (clim:formatting-cell (pane)
              (format pane "Class: "))
            (clim:formatting-cell (pane)
              (format pane "~s" class)))
          (clim:formatting-row (pane)
            (clim:formatting-cell (pane)
              (format pane "Stamp: "))
            (clim:formatting-cell (pane)
              (format pane "~s" (aref rack 0))))
          (loop for slot in (aref rack 1)
                for name = (funcall name-fun slot)
                for location = (funcall location-fun slot)
                do (clim:formatting-row (pane)
                     (clim:formatting-cell (pane)
                       (format pane "~s:" name))
                     (clim:formatting-cell (pane)
                       (format pane "~s" (aref rack location))))))))))
