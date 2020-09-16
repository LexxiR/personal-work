#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 4)

; Function: squareSum
; Purpose: Take a non-negative integer n and return the sum of the squares of all integers 0 through n.
; NOTE: Your function need not behave well on inputs less than zero.
; Parameters: One non-negative integer
; Result: One non-negative integer
(define (squareSum n)
  (if (<= n 0)
      0
      (+ (* n n) (squareSum (- n 1)))))

; Tests for squareSum
(check-expect (squareSum 0) 0)
(check-expect (squareSum 1) 1)
(check-expect (squareSum 2) 5)
(check-expect (squareSum 3) 14)
(check-expect (squareSum 4) 30)
(check-expect (squareSum 5) 55)
(check-expect (squareSum -1) 0) ;Designed to return 0 for negative-integer parameters

(test)
