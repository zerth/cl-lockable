(defpackage :net.mwatters.lockable
  (:nicknames :lockable)
  (:use :common-lisp)
  (:import-from :struct-like-classes
   :define-struct-like-class)
  (:export
   :make-lock
   :with-lock
   :lockable
   :with-thing-locked
   :make-lockable-hash-table
   :with-lockable-hash-table-locked))

(in-package :net.mwatters.lockable)


(defun make-lock (&key name)
  #+single-threaded (declare (ignore name))
  #-single-threaded (bt:make-recursive-lock name))


#+single-threaded
(defmacro with-lock ((lock) &body forms)
  (declare (ignore lock))
  `(progn ,@forms))


#-single-threaded
(defmacro with-lock ((lock) &body forms)
  `(bt:with-recursive-lock-held (,lock) ,@forms))


(define-struct-like-class lockable ()
  (lock (make-lock)))


(defmacro with-thing-locked (what &body forms)
  `(with-lock ((lockable-lock ,what))
     ,@forms))



(define-struct-like-class (lockable-hash-table
                           (:constructor make-lockable-hash-table-1)) (lockable)
  actual)


(defun make-lockable-hash-table (&rest args)
  (make-lockable-hash-table-1 :actual (apply #'make-hash-table args)))


(defmacro with-lockable-hash-table-locked ((var ht) &body forms)
  (let ((v (gensym "V")))
    `(let ((,v ,ht))
       (with-thing-locked ,v
         (let ((,var (lockable-hash-table-actual ,v)))
           ,@forms)))))
