; Pseudo-random number generator
;
; Author: Chris McConnell, ccm@cs.cmu.edu
;
; This file implements a portable pseudo-random number generator for
; Common LISP.  It has been converted from a C program that was
; converted from a FORTRAN program.  I did not pick the variable
; names or pretend to have figured out how it works.  The
; correctness of the generator can be verified by the TEST function
; at the end of the file.
;
; This random number generator is seedable, has a periord of 10^30
; passes all of the statistical tests and is four times faster than the
; built-in ones provided in Allegro and Lucid.
;
; Original C header:
;
;    This is the random number generator proposed by George Marsaglia in
;    Florida State University Report: FSU-SCRI-87-50
;
;    This Random Number Generator is based on the algorithm in a FORTRAN
;    version published by George Marsaglia and Arif Zaman, Florida State
;    University; ref.: see original comments below.
;
;    At the fhw (Fachhochschule Wiesbaden, W.Germany), Dept. of Computer
;    Science, we have written sources in further languages (C, Modula-2
;    Turbo-Pascal(3.0, 5.0), Basic and Ada) to get exactly the same test
;    results compared with the original FORTRAN version.

(defpackage "RANDOM" ; (:nicknames "R")
  (:use #+:lucid "LISP" #-:lucid "COMMON-LISP")
  (:export *state*
       seed-state random-one random-float random-integer random-range
       random-fixnum random-fixnum-range))
(in-package "RANDOM")

(proclaim '(optimize (compilation-speed 0) (speed 3) (safety 0)))

;;;%Globals
(defvar *STATE* nil "The default state structure.")

;;;%%State
(defstruct (STATE (:print-function print-state))
  "This contains random state for a state.  The names of slots are the
same as the variable names in the orginal program."
  (ij 1802 :type fixnum)
  (kl 9373 :type fixnum)
  (u (make-array 97)  ;  :element-type 'single-float
     :type (simple-vector 97)) ;was (simple-array single-float (97))
  (c (/ 362436.0 16777216.0) :type single-float)
  (cd (/ 7654321.0 16777216.0) :type single-float)
  (cm (/ 16777213.0 16777216.0) :type single-float)
  (i97 96 :type fixnum)
  (j97 32 :type fixnum))

;;;
(defun PRINT-STATE (state stream level)
  (declare (ignore level))
  (format stream "#<State ~A ~A>" (state-ij state) (state-kl state)))

;;; %Interface
;;; This is the initialization routine for the random number generator
;;; NOTE: The seed variables can have values between:    0 <= IJ <= 31328
;;;                                                      0 <= KL <= 30081
;;; The random number sequences created by these two seeds are of sufficient
;;; length to complete an entire calculation with. For example, if sveral
;;; different groups are working on different parts of the same calculation,
;;; each group could be assigned its own IJ seed. This would leave each group
;;; with 30000 choices for the second seed. That is to say, this random
;;; number generator can create 900 million different subsequences -- with
;;; each subsequence having a length of approximately 10^30.
;;;
(defun SEED-STATE (&optional (ij (mod (get-internal-real-time) 31329))
                 (kl (mod (get-internal-real-time) 30082)))
  "Given the seed values 0 <= IJ <= 31328 and 0 <= KL <= 30081,
generate a state structure, set it as the default state and return it."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0))
       (fixnum ij kl))
  (let* ((state (make-state :ij ij :kl kl))
     (vector (state-u state))
     (i (+ (the fixnum (mod (the fixnum (truncate ij 177)) 177)) 2))
     (j (+ (the fixnum (mod ij 177)) 2))
     (k (1+ (the fixnum (mod (the fixnum (truncate kl 169)) 178))))
     (l (the fixnum (mod kl 169))))
    (declare (type fixnum i j k l)
         (type (simple-vector 97) vector))
    (dotimes (ii 97)
      (let ((s 0.0)
        (t1 0.5))
    (declare (type single-float s t1))
    (dotimes (jj 24)
      (let ((m (mod (the fixnum (* (mod (the fixnum (* i j)) 179) k))
            179)))
        (declare (type fixnum m))
        (setq i j
          j k
          k m
          l (mod (the fixnum (1+ (the fixnum (* 53 l)))) 169))
        (when (>= (the fixnum (mod (the fixnum (* l m)) 64)) 32)
          (incf s t1))
        (setq t1 (* 0.5 t1))))
    (setf (svref vector ii) s))) ;was aref
    (setq *state* state)))

;;;
(defun RANDOM-ONE (&optional (state *state*))
  "Return a random value between 0.0 and 1.0 from STATE."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0)))
  (let* ((u (state-u state))
     (uni (- (the single-float (svref u (state-i97 state)))
         (the single-float (svref u (state-j97 state)))))) ; was aref
    (declare (type (simple-vector 97) u)
         (type single-float uni))
    (when (minusp uni) (setq uni (+ 1.0s0 uni)))
    (setf (svref u (state-i97 state)) uni) ; was aref
    (when (minusp (the fixnum (setf (state-i97 state)
                    (the fixnum
                     (1- (state-i97 state))))))
      (setf (state-i97 state) 96))
    (when (minusp (the fixnum (setf (state-j97 state)
                    (the fixnum
                     (1- (state-j97 state))))))
      (setf (state-j97 state) 96))
    (when (minusp (the single-float (setf (state-c state)
                      (the single-float
                           (- (state-c state)
                          (state-cd state))))))
      (setf (state-c state) (the single-float
                 (+ (state-c state) (state-cm state)))))
    (when (minusp (the single-float (setf uni (the single-float
                           (- uni (state-c state))))))
      (setq uni (+ 1.0s0 uni)))
    uni))

;;;
(defun RANDOM-FLOAT (n &optional (state *state*))
  "Return a random float between 0 and N.
Use seed-state to initialize a pseudo-random sequence."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0)))
  (* n (the single-float (random-one state))))

;;;
(defun RANDOM-INTEGER (n &optional (state *state*))
  "Return a random integer between 0 and N.
Use seed-state to initialize a pseudo-random sequence."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0)))
  (truncate (* n (the single-float (random-one state)))))

(defun RANDOM-FIXNUM (n &optional (state *state*))
  "Return a random integer between 0 and N.
Use seed-state to initialize a pseudo-random sequence."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0))
       (fixnum n))
  (the fixnum
       (truncate (the single-float
              (* n (the single-float (random-one state)))))))

;;;
(defun RANDOM-NUMBER (n &optional (state *state*))
  "Return a random number between 0 and N with the same TYPE as N.
Use seed-state to initialize a pseudo-random sequence."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0)))
  (if (floatp n)
      (random-float n state)
      (random-integer n state)))

;;;
(defun RANDOM-RANGE (min max &optional (state *state*))
  "Return a number between MIN and MAX with the same type.
Use seed-state to initialize a pseudo-random sequence."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0)))
  (let ((number (+ min (* (- max min) (the single-float (random-one state))))))
    (if (floatp min)
    number
    (truncate number))))

(defun RANDOM-FIXNUM-RANGE (min max &optional (state *state*))
  "Return a fixnum between MIN and MAX.
Use seed-state to initialize a pseudo-random sequence."
  (declare (optimize (compilation-speed 0) (speed 3) (safety 0))
       (fixnum min max)
       (inline random-one))
  (the fixnum
       (+ min
      (the fixnum
           (truncate (the single-float
                  (* (the fixnum (- max min))
                 (the single-float (random-one state)))))))))

(defun TEST ()
  "Test the random number generator.  It should print out n = n T six
times if it works correctly."
  (let ((state (seed-state 1802 9373)))
    (time (dotimes (x 20000)
        (random-one state)))
    (dotimes (x 6)
      (let ((value (round (* 4096 4096 (random-one state))))
        (should-be (svref '#(6533892 14220222 7275067 ; was aref
                 6172232 8354498 10633180) x)))
    (format t "~&~9A = ~9A ~A"
        value should-be (= value should-be))))))

;;;%Initial seed
(setq *state* (seed-state))
(TEST)
(exit)
