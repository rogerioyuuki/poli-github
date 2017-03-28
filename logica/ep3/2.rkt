#lang racket
(require racket/list)
(require racket/set)

(define (simular-nao-deterministico M cadeia)
  (let ([K (first M)] [A (second M)] [d (third M)] [s (fourth M)] [F (list->set (fifth M))])
  (define (transicoes estados w)
    (filter (lambda (t)
      (cond
        [(set-member? estados (first (first t)))
          (if (member (second (first t)) (list #\ϵ (string-ref w 0))) #t #f)]
        [else #f])
      ) d))
  (define (passo estados w)
    (cond
      [(= 0 (string-length w)) (if (set-empty? (set-intersect estados F)) #f #t)]
      [(set-empty? estados) #f]
      [else (let ([prox-transicoes (transicoes estados w)])
        (passo (list->set (flatten (map second prox-transicoes))) (substring w 1)))]))
  (passo (set s) cadeia)))

; M = (K, A, d, s, F)

(define M1 (list '(q0 q1 q2) (list #\a #\b)
      '( ((q0 #\a) q1)
         ((q1 #\b) q0)
         ((q1 #\b) q2)
         ((q2 #\a) q0) )
      'q0 '(q0)))

(define M2 (list '(q0 q1 q2 q3 q4) (list #\1 #\0)
      '( ((q0 #\0) q0)
         ((q0 #\1) q1)
         ((q1 #\0) q2)
         ((q1 #\1) q3)
         ((q2 #\0) q4)
         ((q2 #\1) q0)
         ((q3 #\0) q1)
         ((q3 #\1) q2)
         ((q4 #\0) q3)
         ((q4 #\1) q4) )
      'q0 '(q0)))

(simular-nao-deterministico M1 "aaa")
(simular-nao-deterministico M1 "ba")
(simular-nao-deterministico M1 "ab")
(simular-nao-deterministico M1 "abaaba")