(in-package #:rtg-math.vector4.destructive)

;;---------------------------------------------------------------

(declaim (inline %+)
         (ftype (function (vec4 vec4) vec4)
                %+))
(defun %+ (accum-vec to-add-vec)
  "Add two vectors and return a new vector containing the result"
  (declare (vec4 accum-vec to-add-vec))
  (cl:incf (aref accum-vec 0) (aref to-add-vec 0))
  (cl:incf (aref accum-vec 1) (aref to-add-vec 1))
  (cl:incf (aref accum-vec 2) (aref to-add-vec 2))
  (cl:incf (aref accum-vec 3) (aref to-add-vec 3))
  accum-vec)

(defun + (accum-vec &rest vec4s)
  "Add two vectors and return a new vector containing the result"
  (declare (inline %+))
  (loop :for vec :in vec4s :do (%+ accum-vec vec))
  accum-vec)

(define-compiler-macro + (&whole whole accum-vec &rest vec4s)
  (assert accum-vec)
  (case= (cl:length vec4s)
    (0 accum-vec)
    (1 `(%+ ,accum-vec (first vec4s)))
    (otherwise whole)))

;;---------------------------------------------------------------

(declaim (inline %-)
         (ftype (function (vec4 vec4) vec4)
                %-))
(defun %- (accum-vec to-add-vec)
  "Add two vectors and return a new vector containing the result"
  (declare (vec4 accum-vec to-add-vec))
  (cl:decf (aref accum-vec 0) (aref to-add-vec 0))
  (cl:decf (aref accum-vec 1) (aref to-add-vec 1))
  (cl:decf (aref accum-vec 2) (aref to-add-vec 2))
  (cl:decf (aref accum-vec 2) (aref to-add-vec 3))
  accum-vec)

(defun - (accum-vec &rest vec4s)
  "Add two vectors and return a new vector containing the result"
  (declare (inline %-))
  (loop :for vec :in vec4s :do (%- accum-vec vec))
  accum-vec)

(define-compiler-macro - (&whole whole accum-vec &rest vec4s)
  (assert accum-vec)
  (case= (cl:length vec4s)
    (0 accum-vec)
    (1 `(%- ,accum-vec (first vec4s)))
    (otherwise whole)))

;;---------------------------------------------------------------

(declaim (inline %*)
         (ftype (function (vec4 vec4) vec4)
                %*))
(defun %* (accum-vec to-add-vec)
  "Add two vectors and return a new vector containing the result"
  (declare (vec4 accum-vec to-add-vec))
  (cl:setf (aref accum-vec 0) (cl:* (aref accum-vec 0) (aref to-add-vec 0)))
  (cl:setf (aref accum-vec 1) (cl:* (aref accum-vec 1) (aref to-add-vec 1)))
  (cl:setf (aref accum-vec 2) (cl:* (aref accum-vec 2) (aref to-add-vec 2)))
  (cl:setf (aref accum-vec 3) (cl:* (aref accum-vec 2) (aref to-add-vec 3)))
  accum-vec)

(defun * (accum-vec &rest vec4s)
  "Add two vectors and return a new vector containing the result"
  (declare (inline %*))
  (loop :for vec :in vec4s :do (%* accum-vec vec))
  accum-vec)

(define-compiler-macro * (&whole whole accum-vec &rest vec4s)
  (assert accum-vec)
  (case= (cl:length vec4s)
    (0 accum-vec)
    (1 `(%* ,accum-vec (first vec4s)))
    (otherwise whole)))

;;---------------------------------------------------------------