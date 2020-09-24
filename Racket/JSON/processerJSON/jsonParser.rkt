#lang racket

(require parser-tools/yacc
         (prefix-in lex: parser-tools/lex)
         "jsonLexer.rkt"
         "jsonAbstractSyntaxTree.rkt")

(provide (all-defined-out))

(define myparser
  (parser
   (start json)

      (end EOF)
      (tokens bool-values
              parens
              bracks
              end-of-file
              string
              nullValues
              number
              object
              comma
              colon
              )
      (error (lambda (tok-ok? tok-name tok-value)
               (printf "Parser error: token ~a value ~a"
                           tok-name
                           tok-value)))
      (grammar
          (elems[(TRUE) (TrueVal true)]
                [(FALSE) (FalseVal false)]
                [(NULL) (NullVal null)]
                [(STRING) (StrVal $1)]
                [(NUMBER) (NumVal $1)]
                [(LEFTBRACE Objelems RIGHTBRACE) (ObjVal (list $2))]
                [(LEFTBRACK strelems RIGHTBRACK) (Array $2)]
                [(LEFTBRACE RIGHTBRACE) (ObjVal " ")])

          (ObjElem [(STRING COLON elems) (StrJSONPair $1 $3)])

         (Objelems [( )                               (emptyVal)]
          [(ObjElem)                          (list $1)]
          [(Objelems COMMA Objelems)            (cons $1 $3)])


          (json
          [(elems) $1]
          [(Objelems) $1]
          [(ObjElem) $1]
          [(strelems) $1])

          (strelems [(elems) (list $1)]
             [(strelems COMMA strelems) (cons $1 $3)]
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

;;;(parsefile "cdc2018.json")

;;;Tests (that worked)
;;;(parsestr "1")
;;;(parsestr "null")
;;;(parsestr "true")
;;;(parsestr "false")
;;;(parsestr "[1]")
;;;(parsestr "[1 , 2]")
;;;(parsestr "[1, 2, 3, 4]")
;;;(parsestr "\"id\" : \"test\"")
;;;(parsestr "\"a\":2")
;;;(parsestr "{1:2}")
;;;(parsestr "{\"b\" : \"c\"}")
