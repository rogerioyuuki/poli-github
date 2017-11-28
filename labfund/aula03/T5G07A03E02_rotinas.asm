; Rotinas
; Exportação
chtoi-A1 >
chtoi-A2 >
chtoi-OUT >
chtoi >

itoch-A >
itoch-OUT1 >
itoch-OUT2 >
itoch >
; Importação de constantes
UM <            ; /0001
NEGATIVO <      ; /FFFF
DEZ <           ; /000A
SHIFT <         ; /0010
CHAR-0 <        ; /0030
CHAR-9 <        ; /0039
CHAR-A <        ; /0041
CHAR-F <        ; /0046
A-F-CONVERTER < ; /0037

& /0000

; ------------------
; chtoi

chtoi-A1 $ /0001
chtoi-A2 $ /0001
chtoi-OUT $ /0001
chtoi $ /0001
; reset output
	LV /0000
	MM chtoi-OUT
; start routine

; first byte
	LD chtoi-A1
	MM UNPACK-A
	SC UNPACK
	LD UNPACK-OUT1
	MM chtoi-min-A
	SC chtoi-min
	JN chtoi-error ; if error, jump to chtoi-error
	* SHIFT
	MM chtoi-OUT
; second half:
	LD UNPACK-OUT2
	MM chtoi-min-A
	SC chtoi-min
	JN chtoi-error ; if error, jump to chtoi-error
; byte is valid:
	MM chtoi-temp
	LD chtoi-OUT
	+ chtoi-temp
	MM PACK-A

; second byte
	LD chtoi-A2
	MM UNPACK-A
	SC UNPACK
	LD UNPACK-OUT1
	MM chtoi-min-A
	SC chtoi-min
	JN chtoi-error ; if error, jump to chtoi-error
	* SHIFT
	MM chtoi-OUT
; second half:
	LD UNPACK-OUT2
	MM chtoi-min-A
	SC chtoi-min
	JN chtoi-error ; if error, jump to chtoi-error
; byte is valid:
	MM chtoi-temp
	LD chtoi-OUT
	+ chtoi-temp
	MM PACK-B

; Output
	SC PACK
	LD PACK-OUT
	MM chtoi-OUT
	RS chtoi

chtoi-error LD NEGATIVO
	MM chtoi-OUT
	RS chtoi

chtoi-temp $ =1

; --------------------------------------------------
; sub-rotina chtoi-min
; faz o mesmo que chtoi, mas para 1 caractere apenas
; Ex: /0031 - /0001 , /0046 - /000F, /004b - /FFFF (erro)
chtoi-min-A $ =1
chtoi-min $ =1
; char in range 0-9
	LD chtoi-min-A
	MM inRange-A
	LD CHAR-0
	MM inRange-B
	LD CHAR-9
	MM inRange-C
	SC inRange
	JN chtoi-min-letter

; char is 0-9: char - '0 = 0..9
	LD chtoi-min-A
	- CHAR-0
	RS chtoi-min

; if char is not 0-9, must be A-F:
chtoi-min-letter LD chtoi-min-A
	MM inRange-A
	LD CHAR-A
	MM inRange-B
	LD CHAR-F
	MM inRange-C
	SC inRange
	JN chtoi-min-error
; char is A-F: char - /0037 = A..F
	LD chtoi-min-A
	- A-F-CONVERTER
	RS chtoi-min

chtoi-min-error LD NEGATIVO
	RS chtoi-min

; -------------------------------------
; -------------------------------------
; itoch
itoch-A $ =1
itoch-OUT1 $ =1
itoch-OUT2 $ =1
itoch LD itoch-A
	MM UNPACK-A
	SC UNPACK
; first byte
	LD UNPACK-OUT1
	/ SHIFT ; right-shift - get 1 char
	MM itoch-temp

; first char
	MM itoch-single-A
	SC itoch-single
	MM PACK-A
; get second char
	LD itoch-temp
	* SHIFT
	MM itoch-temp
	LD UNPACK-OUT1
	- itoch-temp
	MM itoch-single-A
	SC itoch-single
	MM PACK-B
; save result
	SC PACK
	MM itoch-OUT1

; second byte
	LD UNPACK-OUT2
	/ SHIFT ; right-shift - get 1 char
	MM itoch-temp

; first char
	MM itoch-single-A
	SC itoch-single
	MM PACK-A
; get second char
	LD itoch-temp
	* SHIFT
	MM itoch-temp
	LD UNPACK-OUT2
	- itoch-temp
	MM itoch-single-A
	SC itoch-single
	MM PACK-B
; save result
	SC PACK
	MM itoch-OUT2

; end
	RS itoch

itoch-temp $ =1


; -------------------------------------
; itoch-single
; converte um caractere apenas
; Ex: /0001 -> /0031 , /000A -> /0041

itoch-single-A $ =1
itoch-single $ =1
	LD itoch-single-A
	- DEZ
	JN itoch-single-number
	JP itoch-single-letter

itoch-single-number LD itoch-single-A
	+ CHAR-0
	RS itoch-single

itoch-single-letter LD itoch-single-A
	+ A-F-CONVERTER
	RS itoch-single

itoch-single-temp $ =1


; -------------------------------------

; Sub-rotina UNPACK
; Inicialização
UNPACK-A $ /0001
UNPACK-OUT1 $ /0001
UNPACK-OUT2 $ /0001
UNPACK $ /0001
	LD UNPACK-A
	MM UNPACK-TEMP
; Auto-modificação:
	LD UNPACK-instr
	- UM
	MM UNPACK-instr1
	MM UNPACK-instr3
	LD UNPACK-instr
	+ UM
	MM UNPACK-instr2
; Byte shift:
UNPACK-instr1 LD UNPACK-TEMP
	MM UNPACK-OUT1
UNPACK-instr2 LD UNPACK-TEMP
	MM UNPACK-TEMP
UNPACK-instr3 LD UNPACK-TEMP
	MM UNPACK-OUT2
	RS UNPACK
; Memória alocada da sub-rotina:
UNPACK-instr LD UNPACK-TEMP ; Instrução principal, a ser modificada
$ /0001
UNPACK-TEMP $ /0001
$ /0001

; Sub-rotina PACK
; Inicialização
PACK-A $ /0001
PACK-B $ /0001
PACK-OUT $ /0001
PACK $ /0001
	LD PACK-A
	MM PACK-TEMP1
	LD PACK-B
	MM PACK-TEMP2
; Auto-modificação:
	LD PACK-instr
	+ UM
	MM PACK-instr1
	LD PACK-instr
	- UM
	MM PACK-instr2
; Byte shift:
PACK-instr1 LD PACK-TEMP2
	MM PACK-TEMP2
PACK-instr2 LD PACK-TEMP2
	MM PACK-OUT
	RS PACK
; Memória alocada da sub-rotina:
PACK-instr LD PACK-TEMP2 ; Instrução principal, a ser modificada
$ /0001
PACK-TEMP1 $ /0001
PACK-TEMP2 $ /0001
$ /0001

; sub-rotina A in (B, C)
; Retorno: 0 - true
;         -1 - false
inRange-A $ =1
inRange-B $ =1
inRange-C $ =1
inRange $ =1
; Se A - B < 0, retorna false
	LD inRange-A
	- inRange-B
	JN inRange-false
; Se C - A < 0, retorna false
	LD inRange-C
	- inRange-A
	JN inRange-false
inRange-true LV /0000
	RS inRange
inRange-false LD NEGATIVO
	RS inRange

# rotinas