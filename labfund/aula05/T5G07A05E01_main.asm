; GETLINEF - MAIN 

GETLINEF <
GL_END <
GL_UL <
GL_BUF <

&	/0000
MAIN	JP	START

VAL_UL	K	/0001		; UL do arquivo
VAL_BUF	K	=10			; Tamanho do buffer
BUFFER	$	=10			; Buffer: algumas posições reservadas


START	LV	BUFFER 		; Param 1: endereço do buffer
		MM	GL_END
		LD	VAL_UL		; Param 2: unidade lógica
		MM	GL_UL
		LD	VAL_BUF		; Param 3: tamanho do buffer
		MM	GL_BUF
		SC	GETLINEF	; Chama subrotina
END		HM	END			; fim do programa

# MAIN
