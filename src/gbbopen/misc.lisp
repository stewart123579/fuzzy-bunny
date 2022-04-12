;;; Written by: Dan Corkill
;;;
;;; Copyright (C) 1998-2016 Dan Corkill <corkill@GBBopen.org>
;;; Part of the GBBopen Project.
;;; Licensed under Apache License 2.0 (see LICENSE for license information).

(in-package :fuzzy-bunny)

(defmacro with-full-optimization ((&key) &body body)
  ;;  The feature :full-safety disables with-full-optimization optimizations:
  `(locally #+full-safety ()
            #-full-safety
            (declare (optimize (speed 3)
                               (safety 0)
                               (space 0)
                               (debug 0)
                               (compilation-speed 0)
                               #+lispworks
                               (system:interruptable 0)))
            ,@body))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun feature-present-p (feature-symbol)
    ;; Checks if :full-safety is on the *features* list (used at execution
    ;; time to conditionalize generated code, in place of read-time
    ;; conditionals)
    (member (symbol-name feature-symbol) *features* :test #'string=)))


(defmacro defcm (&body body)
;;; Shorthand conditional compiler-macro:
  (unless (or (feature-present-p ':full-safety)
              (feature-present-p ':disable-compiler-macros))
    `(define-compiler-macro ,@body)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro while (test &body body)
    `(loop (unless ,test (return))
           ,@body)))
