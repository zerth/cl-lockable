; -*- mode: lisp -*-

(asdf:defsystem :lockable
  :description "Locking/synchronization helper functions and classes."
  :version "0.1"
  :license "MIT"
  :author "Mike Watters <mike@mwatters.net>"
  :depends-on (#-single-threaded :bordeaux-threads
               :struct-like-classes)
  :components ((:file "lockable")))
