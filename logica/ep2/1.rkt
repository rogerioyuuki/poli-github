#lang racket
(require racket/list)

(define (rec conj)
    (cond
        [(not (empty? conj)) (printf "~s~n" (first conj))
                             (rec (rest conj))]))


(rec (list 5 2 7 3 8 9 1))