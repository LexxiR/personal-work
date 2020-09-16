#lang racket

; JSON Lexer
; Lexxi Reddington

; JSON files have the following components:
; true
; false
; null
; a string (surrounded by double quotes and allowing some escaped characters)
; a number (represented as a floating point value)
; an "object" (surrounded by braces and is a list of field/value pairs, separated by commas with a colon between the field and value. The field name is always a string literal, while the value can be any legal JSON value)
; an array of JSON values (surrounded by brackets and with the values separated by commas)

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide (all-defined-out))

; Empty tokens
(define-empty-tokens bools (TRUE FALSE))
(define-empty-tokens nullVal (NULL))
(define-empty-tokens end-of-file (EOF))
(define-empty-tokens left-object (LO))
(define-empty-tokens right-object (RO))
(define-empty-tokens left-array (LA))
(define-empty-tokens right-array (RA))
(define-empty-tokens comma (COMMA))
(define-empty-tokens colon (COLON))

; Non-empty tokens
(define-tokens string (STRING))
(define-tokens number (NUMBER))

; Define the lexer (surface syntax)
(define mylexer
  (lexer
   ["true" (token-TRUE)] ; True
   ["false" (token-FALSE)] ; False
   ["null" (token-NULL)] ; Null
   ;[(:: #\"(:* any-string)#\") (token-STRING lexeme)] ; Strings (including some escape characters)
   [(:: (:: #\" (:+ (:or (complement (:: (:+ any-string) #\" (:+ any-string)))) (:: #\\ #\") ) #\")) (token-STRING lexeme)] ; Strings (including some escape characters)
   ;[(:or (:+ numeric) (:: (:+ numeric) #\. (:+ numeric))) (token-NUMBER lexeme)] ; Numbers (including decimal point/float numbers)

   [(:: (:? #\-) (:or (:+ numeric) (:: (:+ numeric) #\. (:+ numeric)))) (token-NUMBER lexeme)] ; Numbers (including decimal point/float numbers)

   [#\{ (token-LO)] ; Objects begin with a { in JSON
   [#\} (token-RO)] ; Objects end with a } in JSON
   [#\[ (token-LA)] ; Arrays begin with a [ in JSON
   [#\] (token-RA)] ; Arrays end with a ] in JSON
   [#\, (token-COMMA)] ; Catch the commas (used to separate entries in objects and arrays in JSON)
   [#\: (token-COLON)] ; Catch the colons (used in objects in JSON)
   [(eof) (token-EOF)] ; Token for the end of the file
   [whitespace  (mylexer input-port)] ; Catch any whitespace (return lines and regular spaces)
   ))

(define (get-tokenizer in)
  (λ () (mylexer in)))

(define (lex in)
  (let ([tokenizer (get-tokenizer in)])
    (define (lex-function)
      (let ([tok (tokenizer)])
        (cond
          [(eq? tok (token-EOF)) "null"]
          [else (cons tok (lex-function))])))
    (lex-function)))

; For testing the lexer with input strings
(define (lexstr str)
  (lex (open-input-string str)))

; Open a file
(define (lexfile filename)
  (let [[in (open-input-file filename)]]
    (lex in)))

; Lex a JSON file!
;(lexfile "cdc2018.json")
