#lang racket

; JSON Parser
; Lexxi Reddington

(require parser-tools/yacc
         (prefix-in lex: parser-tools/lex)
         "jsonLexer.rkt"
         "jsonAbstractSyntaxTree.rkt")

(provide (all-defined-out))

(define myparser
  (parser
   (start json)
   (end EOF)
   (tokens bools
           nullVal
           end-of-file
           left-object
           right-object
           left-array
           right-array
           comma
           colon
           string
           number)
   (error (lambda (tok-ok? tok-name tok-value)
            (printf "Parser error: token ~a value ~a"
                    tok-name
                    tok-value)))
   (grammar
    (Objexpr [(expr COLON expr) (StrJSONPair $1 $3)]
             [(Objexpr COMMA Objexpr) (cons $1 $3)]
             )
    (expr [(TRUE) (TrueVal true)]
          [(FALSE) (FalseVal false)]
          [(NULL) (NullVal null)]
          [(STRING) (StrVal $1)]
          [(NUMBER) (NumVal $1)]
          [(LO Objexpr RO) (ObjVal $2)]
          [(LA strexpr RA) (Array $2)]
          [(LO RO) (ObjVal " ")]
          )
    (strexpr [(expr) (list $1)]
             [(strexpr COMMA strexpr) (cons $1 $3)]
             )
    (json
          [(Objexpr) (list $1)]
          [(expr) (list $1)]
          )
)))

(define (parse in)
  (myparser (get-tokenizer in)))

(define (parsestr str)
  (let ([in (open-input-string str)])
    (parse in)))

(define (parsefile filename)
  (let ([in (open-input-file filename)])
    (parse in)))

; Testing the JSON Parser
(parsestr "true")
(parsestr "false")
(parsestr "null")
(parsestr "\"Test\"")
(parsestr "\"Hello World\"")
(parsestr "1")
(parsestr "0.5")
(parsestr "\"Hi\":1")
(parsestr "[1,2,3]")
(parsestr "\"Hi\":1,\"id\":1")
(parsestr "{\"test\":{\"id\":1}}")

; Full cdc2018.json takes way too long to load and parse because of the large array at the end
(parsefile "cdc2018_truncated.json")
