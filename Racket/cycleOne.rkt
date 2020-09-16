#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 5)

; Function: cycleOne
; Purpose: Take a list and return a list which is the same as the input parameter list but with the first element of the list moved to the end.
; Parameters: A list
; Result: A list
(define (cycleOne alist)
  (if (empty? alist) '() (append (rest alist) (list (first alist)))))

; Tests for cycleOne
(check-expect (cycleOne '()) '())
(check-expect (cycleOne '(1 2)) '(2 1))
(check-expect (cycleOne '(1 2 3)) '(2 3 1))
(check-expect (cycleOne '(1 2 3 4)) '(2 3 4 1))
(check-expect (cycleOne '(2 4 2 4)) '(4 2 4 2))
(check-expect (cycleOne '(4 5 2 7 2 0 1 9)) '(5 2 7 2 0 1 9 4))

(test)
