#lang racket

;; http://projecteuler.net/problem=4

;; A palindromic number reads the same both ways. The largest
;; palindrome made from the product of two 2-digit numbers is 9009 =
;; 91 × 99.

;; Find the largest palindrome made from the product of two 3-digit
;; numbers.

(require threading)

;; Reverses a string
(define (reverse-string s)
  (~> s
      (string->list)
      (reverse)
      (list->string)))

;; Returns #t if a string is a palindrome
(define (palin? s)
  (equal? s (reverse-string s)))


;; Helper function to sort a list of numbers decending, so it can be
;; used in a thread-last macro
(define (sort-desc ns)
  (sort ns >))

;; Returns the largest palindrome for products of numbers counting
;; from start down to 0
(define (largest-palin start)
  (~>> (for*/list ([i (in-range start 0 -1)]
                   [j (in-range start 0 -1)])
         (* i j))
       (sort-desc)
       (map number->string)
       (filter palin?)
       (first)))

(time (largest-palin 999))

;; Unit tests for the 3 basic functions
(module+ test
  (require rackunit)
  (check-equal? (reverse-string "") "")
  (check-equal? (reverse-string "reverse") "esrever")
  (check-true (palin? ""))
  (check-true (palin? "a"))
  (check-true (palin? "aa"))
  (check-true (palin? "aba"))
  (check-false (palin? "abb"))
  (check-equal? (largest-palin 99) "9009"))
