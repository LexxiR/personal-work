#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 8)

; Function: intersection
; Purpose: Take two lists as parameters and produce a new list which is the intersection of the values in the lists.
; Parameters: Two lists
; Result: One list
(define (intersection list1 list2)
  (if (empty? list1)
      '()
      (if (memberOf? (first list1) list2)
          (cons (first list1) (intersection (rest list1) list2))
          (intersection (rest list1) list2))))

; Tests for intersection
(check-expect (intersection '() '()) '())
(check-expect (intersection '(1) '(1)) '(1))
(check-expect (intersection '(1 2 3 4) '(1 2 3 4)) '(1 2 3 4))
(check-expect (intersection '(1 2 3 4) '()) '())
(check-expect (intersection '(1 2 3 4) '(4 5 6 7)) '(4))
(check-expect (intersection '(1 2 3 4 5 6 7 8) '(0 2 4 6 8)) '(2 4 6 8))

(test)
