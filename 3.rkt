#lang racket

;; http://projecteuler.net/problem=3

;; The prime factors of 13195 are 5, 7, 13 and 29.
;; What is the largest prime factor of the number 600851475143?

(require threading
         memoize)

;; Utility function to find the first occurence of an element in a
;; stream which matches a given predicate
(define (find-first-unsafe p s)
  (let ([first (stream-first s)])
    (if (p first)
        first
        (find-first p (stream-rest s)))))

(define (find-first p s)
  (if (and (stream? s)
           (not (stream-empty? s)))
      (find-first-unsafe p s)
      #f))

;; Returns #t if a number is a prime, memoization reduces time to
;; find to solution to ~50%
(define/memo (prime? n)
  (not (find-first (lambda (x) (zero? (modulo n x)))
                   (in-range 2 n))))

;; Returns the smallest prime factor for a given number, #f if non was
;; found
(define (smallest-factor n)
  (~>> (in-range 2 n)
       (stream-filter prime?)
       (find-first (lambda (x) (zero? (modulo n x))))))

;; Recursive definition of factorization
(define (factorize-rec n ns)
  (let ([sf (smallest-factor n)])
    (if sf
        (factorize-rec (/ n sf) (append ns (list sf)))
        (append ns (list n)))))

(define (factorize n)
  (factorize-rec n '()))

;; (time (factorize 13195))
(time (factorize 600851475143))
