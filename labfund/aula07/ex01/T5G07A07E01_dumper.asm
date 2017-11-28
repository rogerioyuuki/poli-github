dumper		>

			&	/0000

dumper		$	/0001
			jp	loop2
loop1		ld	end
			+	dois
			mm	end
loop2		ld	end
			+	load
			mm	instrucao
instrucao	$	/0001
			pd	/300
			ld	end
			-	lim_cont
			jz	loop_out
			jp	loop1
loop_out	rs	dumper

; constantes
end			k	/0000
lim_cont	k	/0FFE
dois		k	/0002
load		k	/8000

			#	rotinas


