#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 2)

; Function: countIncreases
; Purpose: Take a list of numbers and return how many times the consecutive numbers increase in value
; Parameters: A list of numbers
; Result: An integer/one number
(define (countIncreases alist [acc 0])
  (if (empty? (rest alist))
      acc
      (if (> (first (rest alist)) (first alist))
          (countIncreases (rest alist) (+ acc 1))
          (countIncreases (rest alist) acc)
          )
      )
  )

; Tests for countIncreases
(check-expect (countIncreases '(1 3 2 4 5 1)) 3)
(check-expect (countIncreases '(1 2 3 4)) 3)
(check-expect (countIncreases '(4 3 2 1)) 0)
(check-expect (countIncreases '(1 3 2 4 5 1 2 3 4 5 6)) 8)

(test)
