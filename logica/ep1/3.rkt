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

(define (fecho-reflexivo R)
  (define (refletir par)
    (let ([a (first par)] [b (last par)])
      (list par (list a a) (list b b))))
  (define (iter result remainder)
    (cond
      [(empty? remainder) (remove-duplicates result)]
      [else (let ([par (first remainder)])
        (iter (append result (refletir par)) (rest remainder)))]))
  (iter (list) R))

(define (fecho-transitivo R)
  (define (trans result par)
    (let ([a (first par)] [b (last par)])
      (map (lambda (p) (list-set p 0 a)) (select-element result b))))
  (define (iter result n)
    (cond
      [(eq? n (length result)) result]
      [else (let ([par (list-ref result n)])
        (iter (remove-duplicates (append result (trans result par))) (+ n 1)))]))
  (iter R 0))

(define (fecho-transitivo-reflexivo R)
  (remove-duplicates (fecho-reflexivo (fecho-transitivo R))))


(fecho-reflexivo (list (list 1 2) (list 3 4) (list 1 3)))
(fecho-transitivo (list (list 1 2) (list 2 3) (list 3 4) (list 1 4)))
(fecho-transitivo-reflexivo (list (list 1 2) (list 2 3) (list 3 4)))