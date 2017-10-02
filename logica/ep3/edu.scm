#lang scheme

; automato = (DADOS-ESTADO DADOS-ESTADO ...)
; DADOS-ESTADO = (estado (TRANSICAO TRANSICAO ...))
; TRANSICAO = (entrada (estado estado ...))

(define automato `(("A" (("x" ("B" "C")) ("y" ("D"))))
                   ("B" (("x" ("C")) ("y" ())))
                   ("C" (("x" ("C" "A")) ("y" ())))
                   ("D" (("x" ()) ("y" ("A"))))))

(define start-state "A")
(define final-states `("D"))
(define chain `("x" "x" "y" "y" "x" "x" "x" "y"))

(define (get-transitions aut state)
    (second (first (filter (lambda (x) (eqv? (first x) state)) aut))))

(define (do-transition aut state input)
    (second (first (filter (lambda (transition) (eqv? (first transition) input)) (get-transitions aut state)))))

(define (has-final-state reached-states final-states)
    (foldl 
        (lambda (reached-state acc) 
            (or acc (not (not (member reached-state final-states)))))
        #f 
        reached-states))

(define (simulate-automato aut start-state chain final-states)
    (let ([reached-states (foldl 
        (lambda (input states) 
            (remove-duplicates (flatten 
                (map 
                    (lambda (state) (do-transition aut state input))
                    states))))
        (list start-state)
        chain)]) (list (has-final-state reached-states final-states) reached-states)))

(simulate-automato automato start-state chain final-states)
