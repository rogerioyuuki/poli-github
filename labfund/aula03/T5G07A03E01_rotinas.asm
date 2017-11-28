; VARIAVEIS PACK	
	a	<
	b	<
	pack	>

; VARIAVEIS UNPACK
	in	<
	unpack1	<
	unpack2	<
	unpack	>

; VARIAVEIS STRCMP
	str1	<
	str2	<
	out	<
	strcmp	>

	&	/0000

; PACK
pack	$	/0001
	LD	a
	*	shift
	+	b
	RS	pack


; UNPACK
unpack $	/0001 ; 58
	LD	in ; 5a
	MM	unpack-in ; 5c
	SC	unpacker ; 5e
	RS	unpack		
; SUB-ROTINA UNPACKER
unpacker $	/0001
	LD	unpack-in
	MM	unpack-temp
; auto-modificacao
	LD	instr
	-	eins
	MM	instr1
	MM	instr3
	LD	instr
	+	eins
	MM	instr2
; byte shift:
instr1	LD	unpack-temp
	MM	unpack-out1
instr2	LD	unpack-temp
	MM	unpack-temp
instr3	LD	unpack-temp
	MM	unpack-out2
	RS	unpacker	

unpack-in $	/0001
unpack-out1 $	/0001
unpack-out2 $	/0001

instr	LD	unpack-temp
	$	/0001
unpack-temp $	/0001
	$	/0001


; STRCMP
strcmp	$	/0001
	SC	strcmpsr
	LD	strcmp-out
	MM	out
	RS	strcmp

strcmp-out $	/0001

; STRCMP SUB-ROUTINE
strcmpsr $	/0001
; Reset output
	LV	/0000
        MM	strcmp-out
; Load and check string end
strcmp-ld1 LD	str1
	JZ 	strcmp-end
        MM 	bytecmp-a
strcmp-ld2 LD	str2
        JZ	strcmp-end
        MM	bytecmp-b
; Compare first byte
        SC	bytecmp
        JN	strcmp-end
; Increment
        LD	strcmp-out
        +	eins
        MM	strcmp-out
; Next byte - automod
        LD	strcmp-ld1
        + 	eins
        MM	strcmp-ld1
        LD 	strcmp-ld2
        +	eins
	MM	strcmp-ld2
        JP	strcmp-ld1
strcmp-end RS 	strcmp

; Sub-rotina BYTECMP
; Retorno: 0 - Os bytes são iguais
;          negativo - os bytes não são iguais
; Ex: 1234 e 1200 => 0
;     1100 e 1400 => negativo
bytecmp-a $	/0001
bytecmp-b $	/0001
bytecmp-temp $	/0001
bytecmp $	/0001
; UNPACK first word
	LD	bytecmp-a
        MM 	unpack-in
        SC 	unpacker
        LD 	unpack-out1
        MM 	bytecmp-temp
; UNPACK second word
        LD 	bytecmp-b
        MM 	unpack-in
        SC 	unpacker
        LD 	unpack-out1
; Check if equal
        -	bytecmp-temp
        JZ 	bytecmp-end
        LD 	negativo
bytecmp-end RS	bytecmp

; CONSTANTES
shift   K       /0100
eins    K       /0001
negativo K      /FFFF

	#	rotinas
