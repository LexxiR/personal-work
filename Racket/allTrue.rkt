#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 1)

; Function: allTrue
; Purpose: Take a list of boolean values and return whether the values are all true or not
; Parameters: A list of boolean values
; Result: A boolean (true or false)
; NOTE: allTrue was written such that an empty list returns true
(define (allTrue alist)
  (if (empty? alist) #t (if (equal? #f (first alist)) #f (allTrue (rest alist)))))

; Tests for allTrue
(check-expect (allTrue '(#t #t #f)) #f)
(check-expect (allTrue '(#t #t #t)) #t)
(check-expect (allTrue '(#f #f #f)) #f)
(check-expect (allTrue '(#f #t #t)) #f)
(check-expect (allTrue '()) #t)

(test)
