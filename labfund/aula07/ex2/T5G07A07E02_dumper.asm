DUMPER 		> 
DUMP_INI 	>
DUMP_TAM 	>
DUMP_UL 	>
DUMP_BL 	>
DUMP_EXE 	>

& =0

;======= Parâmetros =========== 
DUMP_INI 	$ =1
DUMP_TAM 	$ =1
DUMP_UL 	$ =1
DUMP_BL 	$ =1
DUMP_EXE 	$ =1
;======= Constantes ===========
UM K =1
DOIS K =2
;=======   Rotinas  ===========

; Sub-rotina: DUMPER
; Variáveis:
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
; Escreve memorio
  ; Reseta counter
    LV =0
    MM DUMPER_COUNT
  ; while:
DUMPER_WHILE LD DUMP_TAM
    - DUMPER_COUNT
    JZ DUMPER_END
; {
    SC write-end
    LD DUMPER_COUNT
    + UM
    MM DUMPER_COUNT
    JP DUMPER_WHILE  
; }
; Endereço executável final
DUMPER_END RS DUMPER

; Sub-rotina: write(AC)
; Escreve no disco o que estiver no acumulador
write $ =1
write-instr PD /0300
    RS write

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

# DUMPER