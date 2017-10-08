#lang racket

;; http://projecteuler.net/problem=5

;; 2520 is the smallest number that can be divided by each of the
;; numbers from 1 to 10 without any remainder.

;; What is the smallest positive number that is evenly divisible by
;; all of the numbers from 1 to 20?

(require threading)

(define (even-divisible? l n)
  (for/and ([i (in-range l 2 -1)])
    (zero? (modulo n i))))

(define (find-even-divisible l)
  (for/first ([i (in-naturals 1)]
              #:when (even-divisible? l (* i l)))
    (* i l)))

(time (find-even-divisible 20))

(module+ test
  (require rackunit)
  (check-equal? (find-even-divisible 10) 2520))
