#lang racket

;; http://projecteuler.net/problem=1

;; If we list all the natural numbers below 10 that are multiples of 3
;; or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.  Find
;; the sum of all the multiples of 3 or 5 below 1000.

(require threading)

(define (matches? x)
  (or (= (modulo x 3) 0)
      (= (modulo x 5) 0)))

(~>> (in-range 1 1000)
     (stream->list)
     (filter matches?)
     (foldr + 0))
