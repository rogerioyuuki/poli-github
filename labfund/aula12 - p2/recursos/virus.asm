AV_TESTE @ /0000

INI			JP	MAIN	; vai para o main

MEM_INI		K	/0000	;endere�o inicial a verificar (inclusive)
MEM_END		K	/003C	;endere�o final a verificar (inclusive) -- ***** MODIFIQUE-O DE ACORDO *****
	
C1			K	/2015	; constantes a serem escritas em 0E00
C2			K	/CAB0	; 
C3			K	/EBAA	;

CTE_1		K	/0001
CTE_1NEG	K	/FFFF
	
MAIN		LD	MEM_INI		; Chamada ao antivirus: passando parametros
			MM	AV_INI		; 
			LD	MEM_END		; 
			MM	AV_END		; 
			SC	ANTIVIRUS	; Chamada ao antivirus
			
			-	CTE_1		; Verifica se tem virus
			JZ	RET_1NEG	; N�o continua a execu��o caso um virus tenha sido detectado

;============================================================================================
;==== Modifique esta regi�o. N�O ESQUE�A de atualizar o valor de MEM_END para cobrir ========
;==== o seu programa inteiro (o valor /003c fornecido cobre apenas o c�digo original ========
;============================================================================================
			LD	C1			; Fazendo o indevido		
			MM	/0F00		
			LD	C2			; Fazendo o indevido		
			MM	/0F02		
			LD	C3			; Fazendo o indevido		
			MM	/0F04		
;============================================================================================
;============================================================================================
;============================================================================================

RET_0		LV	/0000		; "return 0"
FIM_OK		HM 	FIM_OK		; Fim do programa: tudo OK

RET_1NEG	LD	CTE_1NEG	; "return -1"
FIM_NOK		HM 	FIM_NOK		; Fim do programa: erro


; =========== ANTIVIRUS ===========
ANTIVIRUS	K	/0000		; Subrotina Antivirus
			JP	AV_CHECK	; Salta para instru��o OS
AV_INI		K	/0000		; Par�metro: endere�o inicial a verificar (inclusive)
AV_END		K	/0000		; Par�metro: endere�o final a verificar (inclusive)
AV_CHECK	OS	/2A5		; Chamada de supervisor
			RS	ANTIVIRUS	; Retorno de subrotina

# AV_TESTE