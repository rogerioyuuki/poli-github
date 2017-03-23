#lang racket
(require racket/list)
(require racket/string)

(define (simular-deterministico M cadeia)
  (let ([K (first M)] [A (second M)] [d (third M)] [s (fourth M)] [F (fifth M)])
  (define (transicao estado w)
    (assoc (list estado (string-ref w 0)) d))
  (define (passo estado w)
    (cond
      [(= 0 (string-length w)) (if (member estado F) #t #f)]
      [else (let ([prox-transicao (transicao estado w)])
        (if (and prox-transicao)
          (passo (second prox-transicao) (substring w 1))
          #f))]))
  (passo s cadeia)))

; M = (K, A, d, s, F)

(define M1 (list '(s f) (list #\a #\b)
      '( ((s #\a) s)
         ((s #\b) f)
         ((f #\a) f)
         ((f #\b) s) )
      's '(f)))

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

(simular-deterministico M1 "aaa")
(simular-deterministico M1 "abbba")
(simular-deterministico M1 "abba")

(simular-deterministico M2 "101") ; 5
(simular-deterministico M2 "11001") ; 25
(simular-deterministico M2 "1010111") ; 87
(simular-deterministico M2 "11111111") ; 255