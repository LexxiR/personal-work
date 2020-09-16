#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 6)

; Function: cycleN
; Purpose: Take two parameters, count and a list, and produce the same list but with the first element cycled to the end of the list count number of times.
; Parameters: Two parameters, count (a number/integer) and a list
; Result: A list
(define (cycleN count alist)
  (cond
    [(empty? alist) alist]
    [(<= count 0) alist]
    [else (cycleN (- count 1) (cycleOne alist))]))

; Tests for cycleN
(check-expect (cycleN 1 '()) '())
(check-expect (cycleN 0 '()) '())
(check-expect (cycleN 0 '(1 2 3 4)) '(1 2 3 4))
(check-expect (cycleN 1 '(1 2 3 4)) '(2 3 4 1))
(check-expect (cycleN 2 '(1 2 3 4)) '(3 4 1 2))
(check-expect (cycleN 4 '(1 2 3 4)) '(1 2 3 4))

(test)
