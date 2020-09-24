#lang racket

(provide (all-defined-out))

(struct TrueVal (value) #:transparent)
(struct FalseVal (value) #:transparent)
(struct NullVal (value) #:transparent)
(struct StrVal (value) #:transparent)
(struct NumVal (value) #:transparent)
(struct listVal (first second) #:transparent)

(struct StrJSONPair (string json) #:transparent) 
(struct ObjVal (list-of-strjsonpairs) #:transparent)
(struct Array (list-of-json-elements) #:transparent)
(struct emptyVal () #:transparent)

(struct element (list-of-json-elements) #:transparent)
(struct Objelement (list-of-objelements) #:transparent)
(struct groupings (list-of-json-groups) #:transparent)