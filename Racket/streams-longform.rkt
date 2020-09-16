#lang racket
(require test-engine/racket-tests)

; Racket Streams by Lexxi Reddington (longform)

; Stream function for testing purposes only
; Gives the natural numbers in order, starting at 0
(define nats
  (letrec ([f (lambda (x)
             (cons x (lambda ()
                       (f (+ x 1)))))])
    (lambda () (f 0))))

; Stream function for testing purposes only
; Gives the powers of two in order, starting with 2^0
(define powers-two
  (letrec ([f (lambda (x)
             (cons x (lambda ()
                       (f (* x 2)))))])
    (lambda () (f 1))))

; Function 1: next-k-items
; Purpose: Take a stream and a number and produce a list consisting of the next k elements extracted from the stream. Assume k is non-negative.
; Parameters: A stream (s) and a number (k)
; Result: A list
(define (next-k-items s k)
      (cond [(= k 0) '()]
            [else (cons (car (s)) (next-k-items (cdr (s)) (- k 1)))]))

; Tests for next-k-items
(check-expect (next-k-items nats 0) '())
(check-expect (next-k-items nats 1) '(0))
(check-expect (next-k-items nats 2) '(0 1))
(check-expect (next-k-items nats 10) '(0 1 2 3 4 5 6 7 8 9))
(check-expect (next-k-items powers-two 0) '())
(check-expect (next-k-items powers-two 1) '(1))
(check-expect (next-k-items powers-two 2) '(1 2))
(check-expect (next-k-items powers-two 10) '(1 2 4 8 16 32 64 128 256 512))

; Function 2: kth-item
; Purpose: Take a stream and a number and produce the result of extracting k elements from the stream, returning only the last element.
; Very similar to the previous problem, but only returns a single element. Assume k is greater than 0.
; Parameters: A stream (s) and a number (k)
; Result: A list (of only one element)
(define (kth-item s k)
  (last (cond [(= k 0) null]
              [else (cons (car (s)) (next-k-items (cdr (s)) (- k 1)))])))

; Tests for kth-item
(check-expect (kth-item nats 1) 0)
(check-expect (kth-item nats 2) 1)
(check-expect (kth-item nats 3) 2)
(check-expect (kth-item nats 10) 9)
(check-expect (kth-item powers-two 1) 1)
(check-expect (kth-item powers-two 2) 2)
(check-expect (kth-item powers-two 3) 4)
(check-expect (kth-item powers-two 10) 512)

; ADDED TESTS - Tests with the streammaker

; Streammaker function
(define (streammaker func arg)
  (letrec ([f (λ (x)
                (cons x (λ () (f (func x arg)))))])
    (λ () (f arg))))

; Stream of the natural numbers, starting at 0
(define nats* (streammaker (λ (a b) (+ a 1)) 0))

; Stream of ones
(define ones* (streammaker (λ (a b) 1) 1))

; Test using the above streams, incorporating the streammaker
(check-expect (next-k-items nats* 0) '())
(check-expect (next-k-items nats* 1) '(0))
(check-expect (next-k-items nats* 2) '(0 1))
(check-expect (next-k-items nats* 10) '(0 1 2 3 4 5 6 7 8 9))
(check-expect (next-k-items ones* 0) '())
(check-expect (next-k-items ones* 1) '(1))
(check-expect (next-k-items ones* 2) '(1 1))
(check-expect (next-k-items ones* 10) '(1 1 1 1 1 1 1 1 1 1))

(test)
