LOADER		>
LOADER_UL 	>

& =0

;======= Parâmetros =========== 
LOADER_UL $ =1
;======= Constantes ===========
UM K =1
DOIS K =2
GET_DATA GD /0300

MEM_LIMIT K /0FFF

MEM_SIZE_ERROR K /FFFE
CHECKSUM_ERROR K /FFFC
;=======   Rotinas  ===========
;==============================
; Sub-rotina LOADER

LOADER_INI $ =1
LOADER_FIM $ =1 ; Última posição a ser escrita
LOADER_TAM $ =1

LOADER_COUNT $ =1

LOADER $ =1
; Reseta variáveis
    LV =0
    MM LOADER_COUNT
; Configura unidade lógica da sub-rotina load
    LD GET_DATA
    + LOADER_UL
    MM load-instr
; Lê endereço inicial
    SC load
    MM LOADER_INI
; Lê tamanho
    SC load
    MM LOADER_TAM
; Checa se cabe na memória
    LD LOADER_TAM
    - UM
    * DOIS
    + LOADER_INI
    MM LOADER_FIM ; LOADER_FIM = LOADER_INI + (LOADER_TAM - 1) * 2
    LD MEM_LIMIT
    - LOADER_FIM
    JN LOADER_SIZE_ERROR ; IF MEM_LIMIT - LOADER_FIM < 0, erro de memoria
; Lê os blocos
LOADER_WHILE LD LOADER_TAM
    - LOADER_COUNT
    JZ LOADER_TERMINA
; {
    SC bloco
    ; bloco incrementa LOADER_COUNT
    JP LOADER_WHILE
; }
; Lê endereço executavel
LOADER_TERMINA SC load
  RS LOADER

; Erro de memória: para
LOADER_SIZE_ERROR LD MEM_SIZE_ERROR
    RS LOADER
; Erro de checksum: para
LOADER_CHECKSUM_ERROR LD CHECKSUM_ERROR
    RS LOADER

;==============================

; Sub-rotina load
; Lê um dado e coloca no acumulador
load $ =1
load-instr GD /0300
    MM load-last
	  RS load

load-last $ =1
; =======================
; Sub-rotina load(MEM)
; Lê um dado e armazena numa posição da memória
; Se auto-incrementa no final
load-mem-A $ =1
load-mem $ =1
; Configura endereço de memória correto
    LD load-mem-instr
    + load-mem-A
    MM load-mem-write
; Carrega o dado
    SC load
; Escreve na memória
load-mem-write MM =0
; Auto incrementa
    LD load-mem-A
    + DOIS
    MM load-mem-A

    LD load-last ; Restaura acumulador
    RS load-mem

load-mem-instr MM =0
; =======================

; Sub-rotina bloco
; lê um bloco

bloco-size $ =1
bloco-count K =0
bloco-sum K =0

bloco $ =1
; Reseta variaveis
    LV =0
    MM bloco-count
    MM bloco-sum
; Endereço inicial do bloco
    SC load
    MM load-mem-A
    SC calc-checksum
; Tamanho do bloco
    SC load
    MM bloco-size
    SC calc-checksum
; Faz o load da memória
; If bloco-count < bloco-size
bloco-while LD bloco-size
    - bloco-count
    JZ bloco-checksum
; && LOADER_COUNT < LOADER_TAM
    LD LOADER_TAM
    - LOADER_COUNT
    JZ bloco-checksum
; {
    SC load-mem
    SC calc-checksum

    ; bloco-count++
    LD bloco-count
    + UM
    MM bloco-count

    ; LOADER_COUNT++
    LD LOADER_COUNT
    + UM
    MM LOADER_COUNT

    JP bloco-while
; }
bloco-checksum SC load
    - bloco-sum
    JZ bloco-checksum-ok
; Checksum not OK
    JP LOADER_CHECKSUM_ERROR
bloco-checksum-ok RS bloco

; Sub-sub-rotina calc-checksum
calc-checksum $ =1
    LD load-last
    + bloco-sum
    MM bloco-sum
    LD load-last
    RS calc-checksum

# LOADER