#lang racket
(require test-engine/racket-tests)

; Short Functions in Racket by Lexxi Reddington (Part 3)

; Function: downSeries
; Purpose: Produce a list of numbers from high to low (including high and possibly low) separated by step and in sorted descending order
; Parameters: 3 numbers (step, high, low), where step is positive
; Result: A list of numbers
(define (downSeries step high low)
  (if (< high low)
      null
      (cons high (downSeries step (- high step) low))))

; Tests for downSeries
(check-expect (downSeries 3 12 3) '(12 9 6 3))
(check-expect (downSeries 3 8 3) '(8 5))
(check-expect (downSeries  1 2 3) '())
(check-expect (downSeries 1 5 5) '(5))
(check-expect (downSeries 1 -12 -15) '(-12 -13 -14 -15))

(test)
