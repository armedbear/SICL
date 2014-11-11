(cl:in-package #:sicl-extrinsic-hir-compiler)

(defun parse (lambda-list var error default)
  (let ((result '())
	(rest lambda-list))
    (tagbody
     required
       (if (null rest)
	   (progn (push `(unless (null ,var)
			   (funcall ,error "too many arguments"))
			result)
		  (go out))
	   (let ((first (pop rest)))
	     (cond ((eq first '&optional)
		    (go optional))
		   ((eq first '&rest)
		    (go rest))
		   ((eq first '&key)
		    (go key))
		   (t
		    (push `(if (null ,var)
			       (funcall ,error "too few arguments")
			       (setq ,first (pop ,var)))
			  result)
		    (go required)))))
     optional
       (if (null rest)
	   (progn (push `(unless (null ,var)
			   (funcall ,error "too many arguments"))
			result)
		  (go out))
	   (let ((first (pop rest)))
	     (cond ((eq first '&rest)
		    (go rest))
		   ((eq first '&key)
		    (go key))
		   (t
		    (push `(if (null ,var)
			       (setq ,(first first) nil
				     ,(second first) nil)
			       (setq ,(first first) (pop ,var)
				     ,(second first) t))
			  result)
		    (go optional)))))
     rest
       (push `(setq ,(pop rest) (copy-list ,var))
	     result)
       (if (null rest)
	   (progn (push `(unless (null ,var)
			   (funcall ,error "too many arguments"))
			result)
		  (go out))
	   ;; The first element of REST must be &key.
	   (progn (pop rest)
		  (go key)))
     key
       (if (null rest)
	   (progn (push `(unless (or (null ,var)
				     (getf ,var :allow-other-keys))
			   (funcall ,error
				    "unknown keyword argument"
				    (first ,var)))
			result)
		  (go out))
	   (let ((first (pop rest)))
	     (if (eq first '&allow-other-keys)
		 (go out)
		 (destructuring-bind (keyword variable supplied-p) first
		   (push `(if (eq (setq ,variable
					(getf ,var ,keyword ,default))
				  ,default)
			      (setq ,supplied-p nil
				    ,variable nil)
			      (progn (setq ,supplied-p t)
				     (loop while (remf ,var ,keyword))))
			 result)
		   (go key)))))
     out)
    (reverse result)))

(defun build-argument-parsing-code (lambda-list argument-variable error default)
  (let ((remaining-argument-variable (gensym)))
    `(let ((,remaining-argument-variable ,argument-variable))
       ,@(parse lambda-list remaining-argument-variable error default))))
