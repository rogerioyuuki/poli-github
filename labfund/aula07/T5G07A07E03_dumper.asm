DUMP_INI	<
DUMP_TAM	<
DUMP_UL		<
dumper		>

			&	/0000

dumper		$	/0001
			ld	DUMP_TAM ;;;
			*	dois	 ;;;
			-	dois	 ; definicao endereco limite
			+	DUMP_INI ;;;
			mm	lim_cont ;;;
			ld	DUMP_UL  ;;;
			+	putDisco ; definicao disco
			mm	escrever ;;;
			mm	write_end
			mm	write_tam
			ld	DUMP_INI
write_end	$	/0001
			ld	DUMP_TAM
write_tam	$	/0001
			jp	loop2
loop1		ld	DUMP_INI
			+	dois
			mm	DUMP_INI
loop2		ld	DUMP_INI
			+	load
			mm	instrucao
instrucao	$	/0001
escrever	$	/0001
			ld	DUMP_INI
			-	lim_cont
			jz	loop_out
			jp	loop1
loop_out	rs	dumper

; constantes
lim_cont	$	/0001
dois		k	/0002
load		k	/8000
putDisco	k	/e300

			#	rotinas


