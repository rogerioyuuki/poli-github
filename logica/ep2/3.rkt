#lang racket
(require racket/list)
(require racket/string)

(define (remove-length L n)
  (filter (lambda (x) (<= (string-length x) n)) L))

(define (filter-T T l)
  (remove-length (remove-duplicates T) l))

(define (aplicar-regras cadeias regras)
  (define (aplicar w)
    (map
      (lambda (r) (string-replace w (first r) (second r)))
      (filter (lambda (r) (string-contains? w (first r))) regras)))
  (flatten (map aplicar cadeias)))

; G = (V, T, R, S)
(define (gerar-cadeias G l)
  (let ([V (first G)] [T (second G)] [R (third G)] [S (fourth G)])
    (define (iter T)
      (let ([Tnext (filter-T (append T (aplicar-regras T R)) l)])
        (cond
          [(equal? (list->set Tnext) (list->set T)) T]
          [else (iter Tnext)])))
    (iter (list S))))

(define (gramatica-reconhece G w)
  (cond
    [(member w (gerar-cadeias G (string-length w))) #t]
    [else #f]))

(define G1 (list (list "S" "a") (list "a") (list (list "S" "a") (list "S" "aS")) "S"))
(define G2 (list (list "S" "a" "b") (list "a" "b") (list (list "S" "ab") (list "S" "aSb")) "S"))
(define G3 (list (list "S" "B" "a" "b" "c") (list "a" "b" "c") (list (list "S" "aBSc") (list "S" "abc") (list "Ba" "aB") (list "Bb" "bb")) "S"))


(gramatica-reconhece G1 "aaaa")
(gramatica-reconhece G2 "aaaabbbb")
(gramatica-reconhece G3 "aaaabbbbcccc")