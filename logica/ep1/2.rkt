#lang racket
(require racket/list)

(define (select-element conj element)
  (define (iter result remainder)
  (cond
    [(empty? remainder) result]
    [else (if (eq? element (first (first remainder)))
      (iter (append result (list (first remainder))) (rest remainder))
      (iter result (rest remainder)))]))
  (iter (list) conj))


(select-element (list (list 1 2) (list 1 4) (list 1 0) (list 3 11)) 1)

(select-element (list (list 4 2) (list 1 4) (list 1 0) (list 4 11)) 4)

(select-element (list (list 4 2) (list 1 4) (list 1 0) (list 4 11)) 10)

(select-element (list (list 3 2) (list 3 4) (list 3 0) (list 3 11)) 3)