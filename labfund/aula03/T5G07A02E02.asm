; UNPACK
@ /0000
main jp inicio
; Dados:
A K /FAFF
OUT1 $ /0001
OUT2 $ /0001
; Programa
inicio LD A
	MM UNPACK-A
	SC UNPACK
	LD UNPACK-OUT1
	MM OUT1
	LD UNPACK-OUT2
	MM OUT2
fim HM fim

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
UM K /0001
$ /0001
UNPACK-TEMP $ /0001
$ /0001
# main