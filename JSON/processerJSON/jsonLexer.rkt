#lang racket

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide (all-defined-out))


;;;All of these define what token will be in this lexer
(define-empty-tokens nullValues (NULL))
(define-tokens string (STRING))
(define-tokens number (NUMBER))
(define-empty-tokens bool-values (TRUE FALSE))
(define-empty-tokens parens (LEFTBRACE RIGHTBRACE))
(define-empty-tokens bracks (LEFTBRACK RIGHTBRACK))
(define-empty-tokens object (OBJECT))
(define-empty-tokens comma (COMMA))
(define-empty-tokens colon (COLON))
(define-empty-tokens end-of-file (EOF))


;;;this part defines the symbol for each comment 
(define mylexer
  (lexer
      [#\{                       (token-LEFTBRACE)]
      [#\}                        (token-RIGHTBRACE)]
      [#\]                        (token-RIGHTBRACK)]
      [#\[                        (token-LEFTBRACK)]
      [#\,                        (token-COMMA)]
      [#\:                        (token-COLON)]
      ["true"      (token-TRUE)]
      ["false"     (token-FALSE)]
      ["null"     (token-NULL)]
      [(:: (:: #\" (:+ (:or (complement (:: (:+ any-string) #\" (:+ any-string)))) (:: #\\ #\")) #\")) (token-STRING lexeme)]
      [(:: (:? #\-) (:or (:+ numeric) (:: (:+ numeric) #\. (:+ numeric)))) (token-NUMBER lexeme)]
      [whitespace  (mylexer input-port)]
      [(eof)       (token-EOF)]
      ))


(define (get-tokenizer in)
  (lambda () (mylexer in)))

(define (lex in)
  (let ([tokenizer (get-tokenizer in)])
    (define (lex-function)
              (let ([tok (tokenizer)])
                   (cond
                      [(eq? tok (token-EOF)) "null"]
                      [else (cons tok (lex-function))])))
    (lex-function)))


(define (lexstr str)
  (lex (open-input-string str)))

(define (lexfile filename)
  (let [(in (open-input-file filename))]
    (lex in)))

;;;(lexfile "cdc2018.json")


