AV_TESTE @ /0000

INI         JP  MAIN    ; vai para o main

MEM_INI     K   /0000   ;endereço inicial a verificar (inclusive)
MEM_END     K   /0050   ;endereço final a verificar (inclusive) -- ***** MODIFIQUE-O DE ACORDO *****
    
C1          K   /2015   ; constantes a serem escritas em 0E00
C2          K   /CAB0   ; 
C3          K   /EBAA   ;

MEM_SHIFT K /0F00

CTE_1       K   /0001
CTE_1NEG    K   /FFFF
    
MAIN        LD  MEM_INI     ; Chamada ao antivirus: passando parametros
            MM  AV_INI      ; 
            LD  MEM_END     ; 
            MM  AV_END      ; 
            SC  ANTIVIRUS   ; Chamada ao antivirus
            
            -   CTE_1       ; Verifica se tem virus
            JZ  RET_1NEG    ; Não continua a execução caso um virus tenha sido detectado

;============================================================================================
;==== Modifique esta região. NÃO ESQUEÇA de atualizar o valor de MEM_END para cobrir ========
;==== o seu programa inteiro (o valor /003c fornecido cobre apenas o código original ========
;============================================================================================
             LD self-modify1
             + MEM_SHIFT
             MM self-modify1

             LD self-modify2
             + MEM_SHIFT
             MM self-modify2

             LD self-modify3
             + MEM_SHIFT
             MM self-modify3

             LD  C1          ; Fazendo o indevido        
self-modify1 MM  /0000       
             LD  C2          ; Fazendo o indevido        
self-modify2 MM  /0002       
             LD  C3          ; Fazendo o indevido        
self-modify3 MM  /0004       
;============================================================================================
;============================================================================================
;============================================================================================

RET_0       LV  /0000       ; "return 0"
FIM_OK      HM  FIM_OK      ; Fim do programa: tudo OK

RET_1NEG    LD  CTE_1NEG    ; "return -1"
FIM_NOK     HM  FIM_NOK     ; Fim do programa: erro


; =========== ANTIVIRUS ===========
ANTIVIRUS   K   /0000       ; Subrotina Antivirus
            JP  AV_CHECK    ; Salta para instrução OS
AV_INI      K   /0000       ; Parâmetro: endereço inicial a verificar (inclusive)
AV_END      K   /0000       ; Parâmetro: endereço final a verificar (inclusive)
AV_CHECK    OS  /2A5        ; Chamada de supervisor
            RS  ANTIVIRUS   ; Retorno de subrotina

# AV_TESTE