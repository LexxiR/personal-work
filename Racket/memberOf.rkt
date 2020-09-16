#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 7)

; Function: memberOf?
; Purpose: Take a value and a list of values and return true if the list contains the value and false otherwise.
; Parameters: A value and a list of values
; Result: A boolean (#t or #f)
(define (memberOf? val alist)
  (if (equal? alist '())
      #f
      (if (equal? val (first alist))
          #t
          (memberOf? val (rest alist)))))

; Tests for memberOf?
(check-expect (memberOf? 1 '(1 2 3 4)) #t)
(check-expect (memberOf? 1 '(2 3 4 1)) #t)
(check-expect (memberOf? 0 '(1 2 3 4)) #f)
(check-expect (memberOf? "Hey" '("Hi" "Hey" "Hello")) #t)
(check-expect (memberOf? "Bye" '("Hi" "Hey" "Hello")) #f)
(check-expect (memberOf? #t '(#f #f #f)) #f)
(check-expect (memberOf? #t '(#f #t #f)) #t)

(test)
