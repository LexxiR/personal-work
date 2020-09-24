#lang racket
(require test-engine/racket-tests)

; Processing JSON by Lexxi Reddington

(require "jsonAbstractSyntaxTree.rkt"
         "jsonParser.rkt")

(define (eval expression)
  (match expression
    [(TrueVal v) v]
    [(FalseVal v) v]
    [(NullVal v) v]
    [(StrVal v) v]
    [(NumVal v) v]
    [(list e1) (eval e1)]
    [(StrJSONPair e1 e2) (list e1 (eval e2))]
    [(ObjVal lst) (map eval (first lst))]
    [(Array a) (map eval a)]
    ))

; Function 1: objectContains?
; Consumes a JSON Object and a field name and produces a boolean
; If the JSON object contains a field given by the second argument, it will return true and otherwise it returns false
; If the function is called on something that is not an ObjVal, it should throw an error
;

; Type: JSON -> String -> Boolean
; Function Parameters: A JSON Object and a string (field name)
; Function Results: A boolean
(define (objectContains? JSON s)
  (if (ObjVal? JSON)
      (memberOf? s (eval JSON))
      (error "Error ~ Function was called on something that was not an ObjVal")))

; Helper Function: memberOf?
; Completes the objectContains? function
(define (memberOf? val alist)
  (if (equal? alist '())
      #f
      (if (equal? val (second (first alist)))
          #t
          (memberOf? val (rest alist)))))

; TESTS for Function 1: objectContains?
; 'Lexxi' is an included field name, so should return true
(check-expect (objectContains? (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\""))))) "\"Lexxi\"") #t)
; '1' is an included field name, so should return true
(check-expect (objectContains? (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\""))))) "\"1\"") #t)
; 'Bob' is NOT an included field name, so should return false
(check-expect (objectContains? (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\""))))) "\"Bob\"") #f)
; '3' is NOT an included field name, so should return false
(check-expect (objectContains? (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\""))))) "\"3\"") #f)


; Function 2: getField
; Consumes a JSON Object and a field name and produces the JSON value corresponding to that field name
; If the function is called on something that is not an ObjVal, it should throw an error
;

; Type: JSON -> String -> JSON
; Function Parameters: A JSON Object and a string (field name)
; Function Results: A JSON value
(define (getField JSON s)
  (if (ObjVal? JSON)
      (getFieldHelper s (eval JSON))
      (error "Error ~ Function was called on something that was not an ObjVal")))

; Helper Function: getFieldHelper
; Completes the getField function
(define (getFieldHelper n alist)
    (if (equal? n (first (first alist)))
        (second (first alist))
        (getFieldHelper n (rest alist))
        ))

; TESTS for Function 2: getField
; The corresponding JSON value to the field name 'id' is '1'
(check-expect (getField (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\""))))) "\"id\"")  "\"1\"")
; The corresponding JSON value to the field name 'name' is 'Lexxi'
(check-expect (getField (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\""))))) "\"name\"")  "\"Lexxi\"")
; The corresponding JSON value to the field name 'name' is 'Lexxi'
(check-expect (getField (ObjVal (list (list (list (StrJSONPair "\"city\"" (StrVal "\"Amsterdam\""))) (StrJSONPair "\"zip\"" (StrVal "\"12345\""))))) "\"city\"")  "\"Amsterdam\"")
; The corresponding JSON value to the field name 'name' is 'Lexxi'
(check-expect (getField (ObjVal (list (list (list (StrJSONPair "\"city\"" (StrVal "\"Amsterdam\""))) (StrJSONPair "\"zip\"" (StrVal "\"12345\""))))) "\"zip\"")  "\"12345\"")


; Function 3: filterKeys
; Consumes a function of type (String -> Bool) and a JSON Object and then produces another JSON object
; This function will take a predicate function, and apply it to each (key, value) pair in the JSON object
; If the predicate returns True, the pair is kept, else it is ignored
; The function will return a JSON object containing only those keys for which the predicate returned True
; If you call it on something that's not an ObjVal, it should throw an error
;

; Type: A function of type (String -> Bool) -> JSON Object -> JSON Object
; Function Parameters: A function/predicate and a JSON Object
; Function Results: A JSON Object (represented by a list)
(define (filterKeys predicate JSON)
        (if (ObjVal? JSON)
            (reverse (filterKeysHelper predicate (eval JSON) '()))
            (error "Error ~ Function was called on something that was not an ObjVal")))

; Helper Function: filterKeysHelper
; Completes the filterKeys function
(define (filterKeysHelper predicate lst acc)
  (if  (empty? lst)
       acc
       (if (predicate (first lst))
           (filterKeysHelper predicate (rest lst) (cons (first lst) acc))
           (filterKeysHelper predicate (rest lst) acc))))

; TESTS for Function 3: filterKeys
; Predicate used for testing
(define (funcTrue j)
  #t)
; All (key, value) pairs are kept
(check-expect (filterKeys funcTrue (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\"")))))) '(("\"id\"" "\"1\"") ("\"name\"" "\"Lexxi\"")))
; The only (key, value) pair is kept
(check-expect (filterKeys funcTrue (ObjVal (list (list (StrJSONPair "\"id\"" (StrVal "\"1\"")))))) '(("\"id\"" "\"1\"")))
; Predicate used for testing
(define (funcFalse j)
  #f)
; All (key, value) pairs are discarded
(check-expect (filterKeys funcFalse (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\"")))))) '())
; The only (key, value) pair is discarded
(check-expect (filterKeys funcFalse (ObjVal (list (list (StrJSONPair "\"id\"" (StrVal "\"1\"")))))) '())


; Function 4: keyCount
; Consumes a JSON Object and produces an integer
; Produce the number of keys in the JSON object
; If called on something that is not an ObjVal, throw an error
;

; Type: JSON -> int
; Function Parameters: A JSON object
; Function Results: An int (a number)
(define (keyCount JSON)
   (if (ObjVal? JSON)
      (keyCountHelper (eval JSON))
  (error "Error ~ Function was called on something that was not an ObjVal")))

; Helper Function: keyCountHelper
; Completes the keyCount function
(define (keyCountHelper alist)
  (if (empty? alist)
       0
       (+ 1 (keyCountHelper (rest alist)))))

; TESTS for Function 4: keyCount
; There are three keys in the JSON Object below
(check-expect (keyCount (ObjVal (list (list (list (StrJSONPair "\"a\"" (StrVal "\"one\""))) (list (StrJSONPair "\"b\"" (StrVal "\"two\""))) (StrJSONPair "\"c\"" (StrVal "\"three\"")))))) 3)
; There are two keys in the JSON Object below
(check-expect (keyCount (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\"")))))) 2)
; There is one key in the JSON Object below - testing StrVal
(check-expect (keyCount (ObjVal (list (list (StrJSONPair "\"name\"" (StrVal "\"Lexxi\"")))))) 1)
; There are one key in the JSON Object below - testing NumVal
(check-expect (keyCount (ObjVal (list (list (StrJSONPair "\"age\"" (NumVal "\"23\"")))))) 1)


; Function 5: keyList
; Consumes a JSON Object and produces a list of strings which contains all of the keys in the JSON structure
; If called on something that's not an ObjVal, throw an error
;

; Type: JSON -> list (of Strings)
; Function Parameters: A JSON object
; Function Results: A list of Strings
(define (keyList JSON)
  (if (ObjVal? JSON)
      (keyListHelper (eval JSON))
  (error "Error ~ Function was called on something that was not an ObjVal")))

; Helper Function: keyListHelper
; Completes the keyList function
(define (keyListHelper alist)
    (if (empty? alist)
       '()
       (cons (first (first alist)) (keyListHelper (rest alist)))))

; TESTS for Function 5: keyList
; There is one key in the JSON Object below
(check-expect (keyList (ObjVal (list (list (StrJSONPair "\"age\"" (StrVal "\"23\"")))))) '("\"age\""))
; The keys in the JSON Object below are 'id' and 'name'
(check-expect (keyList (ObjVal (list (list (list (StrJSONPair "\"id\"" (StrVal "\"1\""))) (StrJSONPair "\"name\"" (StrVal "\"Lexxi\"")))))) '("\"id\"" "\"name\""))
; The keys in the JSON Object below are 'a', 'b', and 'c'
(check-expect (keyList (ObjVal (list (list (list (StrJSONPair "\"a\"" (StrVal "\"one\""))) (list (StrJSONPair "\"b\"" (StrVal "\"two\""))) (StrJSONPair "\"c\"" (StrVal "\"three\"")))))) '("\"a\"" "\"b\"" "\"c\""))
; The keys in the JSON Object below are 'first', 'second', and 'third'
(check-expect (keyList (ObjVal (list (list (list (StrJSONPair "\"first\"" (StrVal "\"111\""))) (list (StrJSONPair "\"second\"" (StrVal "\"222\""))) (StrJSONPair "\"third\"" (StrVal "\"333\"")))))) '("\"first\"" "\"second\"" "\"third\""))


; Function 6: arrayLength
; Consumes a JSON array and returns the number of elements contained in the array
; If called on something that's not an Array, throw an error
;

; Type: JSON Array -> int
; Function Parameters: A JSON array
; Function Results: An int (a number)
(define (arrayLength JSON)
   (if (Array? JSON)
      (keyCountHelper (eval JSON))
  (error "Error ~ Function was called on something that was not an Array")))

; TESTS for Function 6: arrayLength
; The number of elements contained in the array below is 1
(check-expect (arrayLength (Array (list (NumVal "1")))) 1)
; The number of elements contained in the array below is 2
(check-expect (arrayLength (Array (list (list (NumVal "1")) (NumVal "2")))) 2)
; The number of elements contained in the array below is 3
(check-expect (arrayLength (Array (list (list (NumVal "1")) (list (NumVal "2")) (NumVal "3")))) 3)
; The number of elements contained in the array below is 4
(check-expect (arrayLength (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4")))) 4)


; Function 7: filterRange
; Takes a low and a high value and a JSON Array and returns a JSON array only containing the range of elements between low and high
; If called on something that's not a JSON Array, throw an error
;

; Type: int -> int -> JSON Array -> JSON Array
; Function Parameters: Two ints and a JSON Array
; Function Results: A JSON Array (represented as a list)
(define (filterRange low high JSONarray)
  (if (Array? JSONarray)
      (reverse (filterRangeHelper low high (eval JSONarray) 0 '()))
      (error "Error ~ Function was called on something that was not an Array")))

; Helper Function: filterRangeHelper
; Completes the filterRange function
(define (filterRangeHelper low high lst acc result)
  (if (empty? lst)
      result
      (if (and (<= low acc) (>= high acc))
          (filterRangeHelper low high (rest lst) (+ 1 acc) (cons (first lst) result))
          (filterRangeHelper low high (rest lst) (+ 1 acc) result))))

; TESTS for Function 7: filterRange
; JSON Array '(1 2 3 4) becomes '(3 4) when indices 2-3 are kept
(check-expect (filterRange 2 3 (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4")))) '("3" "4"))
; JSON Array '(1 2 3 4) becomes '(1 2 3) when indices 0-2 are kept
(check-expect (filterRange 0 2 (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4")))) '("1" "2" "3"))
; JSON Array '(1 2 3 4) becomes '(1 2) when indices 0-1 are kept
(check-expect (filterRange 0 1 (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4")))) '("1" "2"))
; JSON Array '(1 2 3 4) becomes '(1) when index 0 is kept
(check-expect (filterRange 0 0 (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4")))) '("1"))


; Function 8: filterArray
; Consumes a function of type (String -> Bool) and a JSON Array, and returns a JSON Array containing only those elements where the predicate function returns True
; If called on something that's not an Array, throw an error
;

; Type: A function of type (String -> Bool) -> JSON Array -> JSON Array
; Function Parameters: A function/predicate and a JSON Array
; Function Results: A JSON Array (represented as a list)
(define (filterArray predicate JSONarray)
  (if (Array? JSONarray)
      (reverse (filterArrayHelper predicate (eval JSONarray) '()))
      (error "Error ~ Function was called on something that was not an Array")))

; Helper Function: filterArrayHelper
; Completes the filterArray function
(define (filterArrayHelper predicate lst result)
  (if (empty? lst)
      result
      (if (predicate (first lst))
          (filterArrayHelper predicate (rest lst) (cons (first lst) result))
          (filterArrayHelper predicate (rest lst) result))))

; TESTS for Function 8: filterArray
; Predicate for testing only
(define (predT JSONval)
  #t)
; Predicate for testing only
(define (predF JSONval)
  #f)
; The entire array should be returned
(check-expect (filterArray predT (Array (list (list (NumVal "-1")) (list (NumVal "-2")) (list (NumVal "3")) (NumVal "4")))) '("-1" "-2" "3" "4"))
; The entire array should be returned
(check-expect (filterArray predT (Array (list (list (StrVal "a")) (list (StrVal "b")) (StrVal "c")))) '("a" "b" "c"))
; None of the array should be returned
(check-expect (filterArray predF (Array (list (list (NumVal "-1")) (list (NumVal "-2")) (list (NumVal "3")) (NumVal "4")))) '())
; None of the array should be returned
(check-expect (filterArray predF (Array (list (list (StrVal "a")) (list (StrVal "b")) (StrVal "c")))) '())


; Function 9: extractElements
; Takes a JSON Array and a list of indices into the array, and returns a new array consisting only of those indices
; If called on something that's not an Array, throw an error
;

; Type: JSON Array -> list (of ints) -> JSON Array
; Function Parameters: A JSON Array and a list
; Function Results: A JSON Array (represented as a list)
(define (extractElements JSONarray indList)
  (if (Array? JSONarray)
      (reverse (extractElementsHelper (eval JSONarray) indList '()))
      (error "Error")))

; Helper Funtion: extractElementsHelper
; Completes the extractEkements function
(define (extractElementsHelper lst indList result)
  (if (empty? indList)
      result
      (extractElementsHelper lst (rest indList) (cons (list-ref lst (first indList)) result))))

; TESTS for Function 9: extractElements
; Only NumVal "2" and NumVal "3" remain after the call asking for indices 1 and 2
(check-expect (extractElements (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4"))) '(1 2)) '("2" "3"))
; Only NumVal "1" remains after the call asking for index 0
(check-expect (extractElements (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4"))) '(0)) '("1"))
; Only NumVal "3" remains after the call asking for index 2
(check-expect (extractElements (Array (list (list (NumVal "1")) (list (NumVal "2")) (list (NumVal "3")) (NumVal "4"))) '(2)) '("3"))
; Only StrVal "Aa" and StrVal "Bb" remain after the call asking for indices 0 and 1
(check-expect (extractElements (Array (list (list (StrVal "Aa")) (list (StrVal "Bb")) (list (StrVal "Cc")) (StrVal "Dd"))) '(0 1)) '("Aa" "Bb"))


; Function 10: increasingIncidents
; A function that processes a JSON file to find all the diseases that have had increasing numbers of incidents since 2013 (the most recent data goes to 2018).
; Because 2018 is not complete, the numbers will be too few, thus only compare the earliest year, 2013, to 2017 for this problem.
;

; Formatter Function: increasingIncidentsFormatter
; Takes in a value from the 'data' array, either an empty list or a number surrounded by too make quotations
; Reprocess the input so that empty lists return 0 and strings return the number inside
(define (increasingIncidentsFormatter val)
  (if (equal? val '())
      0
      (string->number (substring val 1 (- (string-length val) 1)))))

; Helper Function: increasingIncidentsHelper
; Return true if val2017 > val2013
; Used to compare two values from the 'data' array
(define (increasingIncidentsHelper val2017 val2013)
  (if (> val2017 val2013)
      #t
      #f))

; Function 10: increasingIncidents
; Type: file -> void
; Function Parameters: A JSON file
; Function Results: Output is displayed to the console
(define (increasingIncidents file)
  (let ([array (getField (parsefile file) "\"data\"")])
    (for ([i (length array)])
      (let ([str ""])
        (if (increasingIncidentsHelper (increasingIncidentsFormatter (list-ref (list-ref array i) 17)) (increasingIncidentsFormatter (list-ref (list-ref array i) 25)))
            (display (string-append str (list-ref (list-ref array i) 8) ": " (number->string (increasingIncidentsFormatter (list-ref (list-ref array i) 25))) " cases in 2013, " (number->string (increasingIncidentsFormatter (list-ref (list-ref array i) 17))) " cases in 2017\n"))
            (display (string-append str (list-ref (list-ref array i) 8) ": No Increasing Incidents\n"))
            )))))

; TEST for Function 10: increasingIncidents
; Note: The file used for testing here is a shortened version of the original file because the original file took FOREVER to parse, evaluate, and process!
; The shortened file has a shorter body and the 'data' array has only 200 lines instead of almost 1,000
(display "~ All Diseases with Increasing Numbers of Incidents Since 2013 ~\n")
(increasingIncidents "cdc2018_shortened.json")


; Function 11: strictlyIncreasing
; This function returns only those diseases where the number of incidents has been monotonically increasing since 2013.
; To determine if something is monotonically increasing, it uses (>) to compare each year to the year before.
;

; Helper Function: strictlyIncreasingHelper
; Determines if five given values are monotonically increasing
; The result is a boolean
(define (strictlyIncreasingHelper val2013 val2014 val2015 val2016 val2017)
  (if (> val2014 val2013)
      (if (> val2015 val2014)
          (if (> val2016 val2015)
              (if (> val2017 val2016)
                  #t
                  #f)
              #f)
          #f)
      #f))

; Function 11: strictlyIncreasing
; Type: file -> void
; Function Parameters: A JSON file
; Function Results: Output is displayed to the console
(define (strictlyIncreasing file)
  (let ([array (getField (parsefile file) "\"data\"")])
    (for ([i (length array)])
      (let ([str ""])
        (if (strictlyIncreasingHelper (increasingIncidentsFormatter (list-ref (list-ref array i) 25)) (increasingIncidentsFormatter (list-ref (list-ref array i) 23)) (increasingIncidentsFormatter (list-ref (list-ref array i) 21)) (increasingIncidentsFormatter (list-ref (list-ref array i) 19)) (increasingIncidentsFormatter (list-ref (list-ref array i) 17)))
            (display (string-append str (list-ref (list-ref array i) 8) "\n"))
            (display str)
            )))))

; TEST for Function 11: strictlyIncreasing
; Again, the shortened version of the cdc file is used here to decrease runtime
(display "\n~ All Diseases with Monotonically Increasing Numbers of Incidents Since 2013 ~\n")
(strictlyIncreasing "cdc2018_shortened.json")

(test)
