; =============================================================================
; ======================  IMPORTANTE ==========================================
; =============================================================================
; Substitua XX no nome do arquivo por
;
; IF(Seu nome vem ANTES do nome do seu parceiro de grupo, considerando ordem alfabética) {
; 	2 * (seu número de grupo) - 1
; } ELSE {
;	2 * (seu número de grupo)
; }
; =============================================================================
;
;COLOQUE AQUI: Rogério Yuuki Motisuki - 8587052
;


;RDIR
TESTER JP MAIN  ;Início da rotina

K1	K /1234		;Entradas para teste: locais de onde o valor será lido
K2	K /5678
K3	K /789A
K4	K /BCDE		

Res1	K /0000	;Resultados dos teste, para entradas K1 a K3
Res2	K /0000
Res3	K /0000

k1000	K /1000
kC000	K /C000
kF000	K /F000

		; TESTE 1
MAIN	LD K1
		MM WDIR_IN
		LV Res1		;000A
		SC WDIR

		; TESTE 2
		LD K2
		MM WDIR_IN
		LV Res2 
		+  k1000	; 100C
		SC WDIR
		
		; TESTE 3
		LD K3
		MM WDIR_IN
		LV Res3
		+ kC000		; C00E
		SC WDIR
		
		; TESTE 4
		LD K4
		MM WDIR_IN
		LV Res4
		+ kF000		; F800
		SC WDIR

STOP 	HM STOP

; ============================================


;COLOQUE AQUI: Seu código para o WDIR


; ============================================

@ /0800
Res4	K /0000		;Resultado do teste para entrada K4

WDIR_IN $ =1
WDIR 	$ =1
		MM UNPACK-A
		SC UNPACK
		LD UNPACK-OUT1
		/ SHIFT
		* SHIFT
		MM WDIR_TEMP ; Ex: UNPACK-OUT1 = /00F8 -> WDIR_TEMP = /00F0
		LD UNPACK-OUT1
		- WDIR_TEMP
		MM PACK-A
		LD UNPACK-OUT2
		MM PACK-B
		SC PACK
		LD PACK-OUT ; <-- address
		+ WDIR_INSTR ; <-- MM /0000 + ADDRESS
		MM WDIR_MM
; LOAD INPUT AND STORE IN MEMORY
		LD WDIR_IN
WDIR_MM $ =1
RS WDIR

WDIR_TEMP $ =1
WDIR_INSTR		MM /0000 ; instruction to be modified

; =============================================
; CONSTANTES
; =============================================
UM 	K /0001
SHIFT K /0010
; =============================================
; ROTINAS
; =============================================

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


# TESTER