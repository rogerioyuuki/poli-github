; STRCMP
@ /0000
main jp inicio
; Dados:
OUT $ /0001
STR1 K 'va
	K 'ic
	K 'oa
	K 'fe
	K /0000
STR2 K 'va
	K 'ic
	K 'om
	K 'fe
	K /0000
; Programa
inicio SC STRCMP
	LD STRCMP-OUT
	MM OUT
fim HM fim

; Sub-rotina STRCMP
STRCMP-OUT $ /0001
STRCMP $ /0001
; Reset output
	LV /0000
	MM STRCMP-OUT
; Load and check string end
STRCMP-LD1 LD STR1
	JZ STRCMP-END
	MM BYTECMP-A
STRCMP-LD2 LD STR2
	JZ STRCMP-END
	MM BYTECMP-B
; Compare first byte
	SC BYTECMP
	JN STRCMP-END
; Increment
	LD STRCMP-OUT
	+ UM
	MM STRCMP-OUT
; Next byte - automod
	LD STRCMP-LD1
	+ UM
	MM STRCMP-LD1
	LD STRCMP-LD2
	+ UM
	MM STRCMP-LD2
	JP STRCMP-LD1
STRCMP-END RS STRCMP

; Sub-rotina BYTECMP
; Retorno: 0 - Os bytes são iguais
;          negativo - os bytes não são iguais
; Ex: 1234 e 1200 => 0
;     1100 e 1400 => negativo
BYTECMP-A $ /0001
BYTECMP-B $ /0001
BYTECMP $ /0001
; UNPACK first word
	LD BYTECMP-A
	MM UNPACK-A
	SC UNPACK
	LD UNPACK-OUT1
	MM BYTECMP-TEMP
; UNPACK second word
	LD BYTECMP-B
	MM UNPACK-A
	SC UNPACK
	LD UNPACK-OUT1
; Check if equal
	- BYTECMP-TEMP
	JZ BYTECMP-END
	LD NEGATIVO
BYTECMP-END RS BYTECMP
BYTECMP-TEMP $ /0001

; Sub-rotina UNPACK
; Inicialização
UNPACK-A $ /0001
UNPACK-OUT1 $ /0001
UNPACK-OUT2 $ /0001
UNPACK $ /0001
	LD UNPACK-A
	MM UNPACK-TEMP
; Auto-modificação:
	LD instr
	- UM
	MM instr1
	MM instr3
	LD instr
	+ UM
	MM instr2
; Byte shift:
instr1 LD UNPACK-TEMP
	MM UNPACK-OUT1
instr2 LD UNPACK-TEMP
	MM UNPACK-TEMP
instr3 LD UNPACK-TEMP
	MM UNPACK-OUT2
	RS UNPACK
; Memória alocada da sub-rotina:
instr LD UNPACK-TEMP ; Instrução principal, a ser modificada
$ /0001
UNPACK-TEMP $ /0001
$ /0001

; CONSTANTS
UM K /0001
NEGATIVO K /FFFF

# main