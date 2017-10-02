#lang racket
(require racket/list)
(require racket/set)

(define (simular-nao-deterministico M cadeia)
  (let ([K (first M)] [A (second M)] [d (third M)] [s (fourth M)] [F (list->set (fifth M))])
  (define (transicoes estados w)
    (filter (lambda (t)
      (cond
        [(set-member? estados (first (first t)))
          (if (equal? (second (first t)) (string-ref w 0)) #t #f)]
        [else #f])
      ) d))
  (define (fazer-transicoes transicoes)
    (list->set (flatten (map second transicoes))))
  (define (transicoes-vazias estados)
    (let ([prox-estados (set-union estados (fazer-transicoes (transicoes estados "ε")))])
      (cond
        [(equal? prox-estados estados) estados]
        [else (transicoes-vazias prox-estados)])))
  (define (passo estados w)
    (cond
      [(= 0 (string-length w)) (if (set-empty? (set-intersect estados F)) #f #t)]
      [(set-empty? estados) #f]
      [else (let ([prox-estados (fazer-transicoes (transicoes (transicoes-vazias estados) w))])
        (passo (transicoes-vazias prox-estados) (substring w 1)))]))
  (passo (set s) cadeia)))

; M = (K, A, d, s, F)

(define M1 (list '(q0 q1 q2) (list #\a #\b)
      '( ((q0 #\a) q1)
         ((q1 #\b) q0)
         ((q1 #\b) q2)
         ((q2 #\a) q0) )
      'q0 '(q0)))

(define M2 (list '(s q0 q1 q2 f) (list #\a #\b)
      '( ((s #\ε) q0)
         ((q0 #\a) q0)
         ((q0 #\b) q1)
         ((q1 #\ε) f)
         ((q1 #\a) q1)
         ((q1 #\b) q2)
         ((q2 #\a) q2)
         ((q2 #\b) q0) )
      's '(f)))

(simular-nao-deterministico M1 "aaa")
(simular-nao-deterministico M1 "ba")
(simular-nao-deterministico M1 "ab")
(simular-nao-deterministico M1 "abaaba")

(simular-nao-deterministico M2 "aaa")
(simular-nao-deterministico M2 "abaa")
(simular-nao-deterministico M2 "abaabb")
(simular-nao-deterministico M2 "abaabbb")
