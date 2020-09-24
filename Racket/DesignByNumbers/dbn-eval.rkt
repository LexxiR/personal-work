#lang racket

; Lexxi Reddington
; Final Project for Programming Languages: Design By Numbers
; November 2019

(require "dbn-ast.rkt" "dbn-parser.rkt" "papersim.rkt" "dbn-env.rkt" "dbn-errors.rkt")

; generic evaluate from an input port
(define (eval-dbn in [env #f] [run-sim #t] [clear? #t])
  ; reset errors before we move on
  (reset-errors!)
  ; this creates an ast from in
  (let ([prog (parse in)])
    (if (not (parser-error))
        ; see if we should run the sim
        (begin
          (when (eq? run-sim #t)
            (run-paper-sim))
          (set-antialias 'aligned)
          ; evaluate the statements
          (eval-statements (empty-env) (program-statements prog))
          ; refresh to make sure things draw
          (refresh))
        (error "quitting due to parse error"))))

; evaluate a file
(define (eval-file filename [env #f] [run-sim #t] [clear? #t])
  (let ([in (open-input-file filename)])
    (run-paper-sim)
    (eval-dbn in env run-sim clear?)
    (refresh)))

; evaluate a string
(define (eval-str str)
  (let ([in (open-input-string str)])
    (eval-dbn in)))


; evaluates all the files under a directory
(define (eval-dir dirname sleeplen [env #f] [run-sim #t] [clear? #t])
  (run-paper-sim)
  (fold-files (λ (path kind acc)
                (cond
                  [(eq? kind 'file)
                   (printf "Evaluating ~a~n" path)
                   (eval-file path env #t clear?)
                   (refresh)
                   (printf "Enter for next one:")
                   (read (current-input-port))])) #f dirname #f))

; evaluate the list of statements
(define (eval-statements env statements [slow? #f])
  ; this is simply a fold, but we pass the environment along
  ; in the accumulator so we can update it from statement to statement
  ; as needed, this means sometimes we have to keep it! notice that
  ; foldl takes the arguments opposite of foldl in Haskell (accumulator
  ; comes last, not first
  (unless (not slow?) (sleep slow?))
  (foldl-and-exit (λ (s e) (eval-statement e s #f)) env statements))
  

; this is like foldl, but you can exit
(define (foldl-and-exit fun acc lst)
  ; if the list is empty, return the accumulator
  (if (null? lst)
      acc
      ; otherwise, recurse
      (let* ([el (first lst)]
             [result (fun el acc)])
        (match result
          [(cons 'exit v) v]
          [else (foldl-and-exit fun result (rest lst))]))))

; This function evaluates statements, but it also accumulates the
; environment, meaning that it will pass the environment from fun
; to fun
(define (eval-statement env statement [slow? #f])
  (unless (not slow?) (sleep slow?))
  (match statement
    ; Paper 
    [(paper-expr exp xs ys) 
     (clear-paper (dbncolor (eval-expr env exp))) env]    
    ; Pen
    [(pen-expr exp)
     (set-pen-color! (dbncolor (eval-expr env exp))) env]
    ; Print
    [(print-expr exp) (printf "~a~n" (eval-expr env exp)) env]

    ; TODO: Add Line expressions
    
    ; Added by Lexxi
    ; Evaluate the parameters to the line expression below then call the draw-line function in papersim.rkt
    [(line-expr exp1 exp2 exp3 exp4) (draw-line (eval-expr env exp1) (eval-expr env exp2) (eval-expr env exp3) (eval-expr env exp4)) env]
    
    ; Assignment to a paper location, this is a special case
    [(assignment-expr (get-paper-loc x y) color)
     (let ([xcoord (eval-expr env x)]
           [ycoord (eval-expr env y)]
           [col (eval-expr env color)])
       (draw-point xcoord ycoord (dbncolor col)))
     env]

    ; Added by Lexxi
    [(load-expr filename) (eval-file (~a "ExamplePrograms/" filename)) env]

    
    ; Assignment to a variable name, need to see if it's there first
    ;;; TODO: Add variable assignment, this requires using the environment
    ;;;       to see if it's there and creating it if it's not

    ; Added by Lexxi
    ; To add a variable to the environment, extend the environent if the variable does not exist yet
    [(assignment-expr name value) (if (not (apply-env env (eval-expr env value)))
                                      (extend-env env name(eval-expr env value))
                                      (setref! name (eval-expr env value)))]
                                             

    ; the antialias expression, for setting up antialias stuff
    [(antialias-expr expr)
     (let ([val (eval-expr env expr)])
       (cond [(= val 0) (set-antialias 'aligned)]
             [(< val 0) (set-antialias 'unaligned)]
             [else (set-antialias 'smoothed)]))]

    ; Repeat!
    [(repeat-expr sym from to body)
     (let* ([start (eval-expr env from)] ; evaluate the start value
            [end (eval-expr env to)]     ; then the ending value
            [newenv (extend-env env sym start)]
            [ref (apply-env newenv sym)])
       (letrec ([loop (λ () (cond [(<= (deref ref) end)                                   
                                   (eval-statements newenv body slow?)
                                   (setref! ref (add1 (deref ref)))
                                   ;(printf "repeat from ~a to ~a~n" (deref ref) end)
                                   (refresh)
                                   (loop)]))])
         (loop)
         env))]

    ; Forever loops
    [(forever-expr body)
     ; just loop forever, reuse the env from when we entered the loop
     (letrec ([loop (λ ()
                      (eval-statements env body slow?)
                      (refresh)
                      (loop))])
       (loop)
       env)]

    ; boolean-like expressions--we execute the body depending on whether or not they return true
    ; Same? 
    [(same-expr expr1 expr2 body)
     (let ([val1 (eval-expr env expr1)]
           [val2 (eval-expr env expr2)])       
       (when (equal? val1 val2) (eval-statements env body slow?))
       env)]
    
    ; NotSame?
    [(not-same-expr expr1 expr2 body)
     (let ([val1 (eval-expr env expr1)]
           [val2 (eval-expr env expr2)])
       (when (not (equal? val1 val2)) (eval-statements env body slow?))
       env)]

    ; Smaller?
    [(smaller-expr expr1 expr2 body)
     (let ([val1 (eval-expr env expr1)]
           [val2 (eval-expr env expr2)])
       (when (< val1 val2) (eval-statements env body slow?))
       env)]

    ; NotSmaller?
    [(not-smaller-expr expr1 expr2 body)
     (let ([val1 (eval-expr env expr1)]
           [val2 (eval-expr env expr2)])
       (when (not (< val1 val2)) (eval-statements env body))
       env)]

    ; Value statement, this is like a return, so we don't need to
    ; pass on the current environment since it should really be the
    ; last thing done in a list of statements
    [(value-expr expr) (cons 'exit (eval-expr env expr))]
    
    
    ; to create a function, we need to create a closure and store it in the
    ; current environment, so a new environment will be passed on here
    ;;; TODO [(command-fun sym params body)

    ; Added by Lexxi
    [(command-fun sym params body) (let* ([fundef (closure sym params body env)]
                                          [newenv (extend-env env sym fundef)])
                                     newenv)]
     
    ; and we do the same thing for the numbers
    ;;; TODO (Achievement) [(number-fun sym params body)

    ; Added by Lexxi
    [(number-fun sym params body) (let* ([fundef (closure sym params body env)]
                                         [newenv (extend-env env sym fundef)])
                                    newenv)]

    ; now for expressions as statements, these we ignore the return value of
    ;;; TODO: application as statements, I've left some comments to help you along
    ; [(apply-expr sym exprs)  
     ; evaluate all the arugments, then call the function
         ; make sure we found it, or return an error otherwise
       ; return the previous environment to be carried along
    
    ; Added by Lexxi 
    [(apply-expr sym exprs) (let ([results (eval-mult-exprs env exprs)] ; evaluate all the arugments, then call the function
                                  [ref (apply-env env sym)])
                              (if ref ; make sure we found it, or return an error otherwise
                                  (let* ([cur-closure (deref ref)] ; grab closure and all parameters (below)
                                         [var-identifiers (closure-params cur-closure)]
                                         [cur-body (closure-body cur-closure)]
                                         [cur-env (closure-env cur-closure)]
                                         [params (map
                                                  (lambda (param result)
                                                    (cons param (memref param result)))
                                                  var-identifiers
                                                  results)])   
                                    (set! cur-env (foldl ; Extend the current environmet
                                                   (lambda (parameters environment)
                                                     (cons parameters environment))
                                                   cur-env params))
                                    (eval-statements cur-env cur-body)) ; Evaluate all statements and return the result
                                  (error "An Error Has Occurred ~ " sym)) ; ref was not found
                              env ; Return the environment
                              )]))

; Helper Function for apply-expr
; Used to evaluate multiple expressions at once and build a list of these evaluated expressions
 (define (eval-mult-exprs env exprs)
   (foldr
    (λ (expr alist)
      (cons (eval-expr env expr) alist))
    '()
    exprs))

(define (eval-expr env expr)
  (match expr
    ; literal numbers
    [(numeric-expr a) a]

    ; variable lookups
    [(var-expr sym) (let [(val (apply-env env sym))]
                      (if val
                          (deref val)
                          (error "undefined variable " sym)))]
    
    ; used as an expression, the paper location returns the color
    [(get-paper-loc x y)
     (let* ([xcoord (eval-expr env x)]
            [ycoord (eval-expr env y)]
            [color (get-pixel-color xcoord ycoord)])
       color)]

    ; math operations
    [(add-expr a b) (+ (eval-expr env a) (eval-expr env b))]
    [(sub-expr a b) (- (eval-expr env a) (eval-expr env b))]
    [(div-expr a b) (/ (eval-expr env a) (eval-expr env b))]
    [(mult-expr a b) (* (eval-expr env a) (eval-expr env b))]

    ; read mouse info
    [(mouse-expr expr)
     (let ([val (eval-expr env expr)])
       (cond
         [(= val 1) (get-mouse-x)]
         [(= val 2) (get-mouse-y)]
         [(= val 3) (get-mouse-button)]
         [else (error "Expected a mouse value from 1 to 3 inclusive, got " val " instead.")]))]

    ; read key info
    [(key-expr expr)
     (let ([val (eval-expr env expr)])
       ; uh, this seems a little limiting, we can only read 26 keys?
       (cond [(and (>= val) (<= val 26)) (get-key val)]
             [else (error "Expected a key range from 1 to 26 inclusive, got " val " instead.")]))]
    
    ; time expressions
    [(time-expr expr)
     (let ([val (eval-expr env expr)])
       (cond [(= val 1) (get-time 'hour)]
             [(= val 2) (get-time 'minutes)]
             [(= val 3) (get-time 'seconds)]
             [(= val 4) (get-time 'milliseconds)]
             [else (error "Expected a Time range from 1 to 4 inclusive, got " val " instead")]))]
                        

    ; handle function application as an expression, these we care about the return value
    ;;; TODO: function application as an expression (not a statement)--you should return
    ; the result of the evaluation of all the statements in the body
    ; [(apply-expr sym exprs)
     ; evaluate all the arugments, then call the function
         ; make sure we found it, or return an error otherwise
                  ; grab the closure from the environment, which has parameters
                     ; then evaluate all the statements and return the result

    [(apply-expr sym exprs)
 (let ([results (eval-mult-exprs env exprs)]
       [ref (apply-env env sym)])
       ; Determine if the sym exsists in the current environment
   ; Make sure we found it, or return an error otherwise
       (if ref
        ; Grab the closure from the environment, which has parameters
           (let* ([cur-closure (deref ref)]
                  [var-identifiers (closure-params cur-closure)]
                  [cur-body (closure-body cur-closure)]
                  [cur-env (closure-env cur-closure)]
                  [params (map
                             (lambda (param result)
                               (cons param (memref param result)))
                             var-identifiers
                             results)])
             ; Extend the current environmet
             (set! cur-env (foldl
                  (lambda (parameters environment)
                    (cons parameters environment))
                  cur-env params))
             ; Evaluate all the statements and return the result
             (eval-statements cur-env cur-body))
           (error "An Error Has Occurred ~ " sym)))]))


; Testing Design By Numbers Programs
; Evidence that the lexer, parser, and evaluator work are 
; Run every program in the ExamplePrograms folder at once
; Iterate through each program's drawing
(eval-dir "./ExamplePrograms/" 2)

; NOTE: You might have to delete the ".DS_Store" file that OS automatically generates within "ExamplePrograms" :/

; The commands below run programs with Forever loops

;(eval-file "ExamplePrograms/Program-ch14-p167-1.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p168-1.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p168-2.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p169-1.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p170-1.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p170-2.dbn")
;(eval-file "ExamplePrograms/Program-ch14-p171-1.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p171-2.dbn") -- runs forever
;(eval-file "ExamplePrograms/Program-ch14-p172-2.dbn") -- runs forever