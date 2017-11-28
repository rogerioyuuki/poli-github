dump_ini	<
dump_tam	<
dump_ul		<
dumper		>

			&	/0000

dumper		$	/0001
			ld	dump_tam ;;;
			*	dois	 ;;;
			-	dois	 ; definicao endereco limite
			+	dump_ini ;;;
			mm	lim_cont ;;;
			ld	dump_ul  ;;;
			+	putDisco ; definicao disco
			mm	escrever ;;;
			mm	write_end
			mm	write_tam
			ld	dump_ini
write_end	$	/0001
			ld	dump_tam
write_tam	$	/0001
			jp	loop2
loop1		ld	dump_ini
			+	dois
			mm	dump_ini
loop2		ld	dump_ini
			+	load
			mm	instrucao
instrucao	$	/0001
escrever	$	/0001
			ld	dump_ini
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


