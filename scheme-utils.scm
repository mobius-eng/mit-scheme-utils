;;; -*- Mode: Scheme -*-
(declare (usual-integrations))

;;; Useful syntax extensions:
;; Conditionals
(define-syntax when
  (syntax-rules ()
    ((when ?test ?expr ...)
     (if ?test
	 (begin ?expr ...)))))

(define-syntax unless
  (syntax-rules ()
    ((unless ?test ?expr ...)
     (if ?text
	 (begin ?expr ...)))))

(define-syntax if-let
  (syntax-rules ()
    ((if-let (?name ?expr) ?conseq)
     (let ((?name ?expr))
       (if ?name
	   ?conseq)))
    ((if-let (?name ?expr) ?conseq ?alter)
     (let ((?name ?expr))
       (if ?name
	   ?conseq
	   ?alter)))))

;; Destructuring list
(define-syntax dlist-int
  (syntax-rules ()
    ((dlist-int () ?list-expr ?exprs ...)
     (begin ?exprs ...))
    ((dlist-int (?a) ?list-expr ?exprs ...)
     (begin
       (set! ?a (car ?list-expr))
       ?exprs ...))
    ((dlist-int (?a ?b ...) ?list-expr ?exprs ...)
     (begin
       (set! ?a (car ?list-expr))
       (dlist-int (?b ...) (cdr ?list-expr) ?exprs ...)))))

(define-syntax dlist
  (syntax-rules ()
    ((dlist (?a ...) ?list-expr ?exprs ...)
     (let ((lst ?list-expr) (?a #f) ...)
       (dlist-int (?a ...) lst ?exprs ...)))))

;; Destructuring alist (destructuring assoc)
(define (assoc-default item alist default)
  (if-let (x (assoc item alist))
	  (cdr x)
	  default))

(define-syntax dassoc
  (syntax-rules ()
    ((dassoc (?a ...) ?assoc-list ?expr ...)
     (let ((?alist ?assoc-list))
       (let ((?a (assoc-default '?a ?alist #f))
	     ...)
	 ?expr ...)))))

;;; List procedures
;; Convert plist to alist
(define (list->alist lst)
  (cond ((null? lst) '())
	((null? (cdr lst)) (error 'list->alist
				  "arg must have even number of memebers"
				  lst))
	(else (cons (cons (car lst) (cadr lst))
		    (list->alist (cddr lst))))))

;;; Functional" procedures
;; Constant function
(define (constantly c)
  (lambda args
    (declare (ignore args))
    c))

;; Partial application
(define (partial proc . args)
  (lambda more-args
    (apply proc (append! args more-args))))

;; Get nested properties out of object with message passing style
(define (obj-get obj . props)
  (if (null? props)
      obj
      (apply obj-get (obj (car props)) (cdr props))))

;; Uniformity across Scheme implementations 
(define sub1 -1+)
(define add1 1+)



