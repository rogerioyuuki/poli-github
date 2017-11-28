DUMPER      > 
DUMP_INI    >
DUMP_TAM    >
DUMP_UL     >
DUMP_BL     >
DUMP_EXE    >

& =0

;======= Parâmetros =========== 
DUMP_INI    $ =1
DUMP_TAM    $ =1
DUMP_UL     $ =1
DUMP_BL     $ =1
DUMP_EXE    $ =1
;======= Constantes ===========
UM K =1
DOIS K =2
;=======   Rotinas  ===========

; Sub-rotina: DUMPER
; Variável compartilhada bloco-DUMPER:
DUMPER_COUNT K =0

DUMPER $ =1
; Configura unidade lógica de escrita
    LD write-instr
    + DUMP_UL
    MM write-instr
; Escreve começo do arquivo: DUMP_INI e DUMP_TAM
    LD DUMP_INI
    SC write
    LD DUMP_TAM
    SC write
; Configura leitura de memória
    LD DUMP_INI
    MM write-end-A
; Escreve blocos
  ; Reseta counter
    LV =0
    MM DUMPER_COUNT
  ; while:
DUMPER_WHILE LD DUMP_TAM
    - DUMPER_COUNT
    JZ DUMPER_END
; {
    SC bloco
    ; bloco incrementa DUMPER_COUNT
    JP DUMPER_WHILE  
; }
; Endereço executável final
DUMPER_END LD DUMP_EXE
    SC write
; fim
    RS DUMPER

; Sub-rotina: write(AC)
; Escreve no disco o que estiver no acumulador
write $ =1
    MM write-last
write-instr PD /0300
    RS write
; Ultimo dado escrito
write-last $ =1

; Sub-rotina: write(END)
; Escreve no disco a memória de um endereço, auto-incrementando no final
write-end-A $ =1
write-end $ =1
    LD write-end-instr
    + write-end-A
    MM write-end-load
write-end-load LD =0
    SC write
    LD write-end-A
    + DOIS
    MM write-end-A
    RS write-end
; Instrução de Load
write-end-instr LD =0

; Sub-rotina: bloco()
; Escreve no disco um bloco
bloco $ =1
; Reseta variaveis
    LV =0
    MM bloco-count
    MM bloco-sum
; Endereço inicial do bloco
    LD write-end-A
    SC write
    SC calc-checksum
; Tamanho do bloco
; min(DUMP_TAM - DUMPER_COUNT, DUMP_BL)
    LD DUMP_TAM
    - DUMPER_COUNT
    MM min-A
    LD DUMP_BL
    MM min-B

    SC min
    SC write
    SC calc-checksum
; Faz o dump da memória
; If bloco-count < DUMP_BL
bloco-while LD DUMP_BL
    - bloco-count
    JZ bloco-checksum
; && DUMPER_COUNT < DUMP_TAM
    LD DUMP_TAM
    - DUMPER_COUNT
    JZ bloco-checksum
; {
    SC write-end
    SC calc-checksum

    ; bloco-count++
    LD bloco-count
    + UM
    MM bloco-count

    ; DUMPER_COUNT++
    LD DUMPER_COUNT
    + UM
    MM DUMPER_COUNT

    JP bloco-while
; }
bloco-checksum LD bloco-sum
    SC write
    RS bloco

bloco-count K =0
bloco-sum K =0

; Sub-sub-rotina calc-checksum
calc-checksum $ =1
    LD write-last
    + bloco-sum
    MM bloco-sum
    RS calc-checksum

; Sub-rotina min(A,B)
min-A $ =1
min-B $ =1
min $ =1
; If A - B < 0, return A.
; Else, return B

    LD min-A
    - min-B
    JN min-return-A
; return B
    LD min-B
    RS min
; return A
min-return-A LD min-A
    RS min

# DUMPER