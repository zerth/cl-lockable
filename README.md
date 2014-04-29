lockable
========

Locking/synchronization helper functions and classes for Common Lisp.

Usage:

```
(defclass foo (lockable:lockable)
  ((bar :initform nil)))

(defun update-foo (obj new-bar)
  (lockable:with-thing-locked obj
    (setf (slot-value obj 'bar) new-bar)))
```

```
(defvar *sessions* (lockable:make-lockable-hash-table))

(defun record-session (id obj)
  (lockable:with-lockable-hash-table-locked (ht *sessions*)
    (setf (gethash id ht) obj)))
```
