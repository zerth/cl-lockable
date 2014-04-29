; -*- mode: lisp -*-

(asdf:defsystem :lockable
  :depends-on (#-single-threaded :bordeaux-threads
               :struct-like-classes)
  :components ((:file "lockable")))
