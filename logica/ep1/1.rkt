#lang racket
(require racket/list)

(define (rec conj)
    (cond
        [(not (empty? conj)) (printf "~s~n" (first conj))
                             (rec (rest conj))]))


(rec (list (list 1 2) (list 3 4) (list 9 0) (list 10 11)))