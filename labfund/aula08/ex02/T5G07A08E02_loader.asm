;endereco inicial
;tamanho da imagem
;+tratamento de erro (maior que a memoria)

LOADER_UL		<
LOADER			>

				&	/0000

LOADER			$	/0001
				ld	LOADER_UL
				+	read_disco
				mm	ler_end
				mm	ler_tam
				mm	instr_leitura
ler_end			$	/0001
				mm	endereco
ler_tam			$	/0001
				mm	tamanho
				ld	tamanho
				*	dois
				-	dois
				+	endereco
				mm	end_final
				-	limite_memoria
				jn	loop
				jz	loop
				jp	erro

loop			ld	endereco
				+	save
				mm	escrita
instr_leitura	$	/0001
escrita			$	/0001

				ld	endereco
				-	end_final
				jz	fim_leitura

				ld	endereco
				+	dois
				mm	endereco

				jp	loop

fim_leitura		rs	LOADER

erro			ld	error_msg_1
				rs	LOADER

; constantes
error_msg_1		k	/fffe ; nao cabe na memoria
error_msg_2		k	/fffc
read_disco		k	/d300
limite_memoria	k	/0ffe
save			k	/9000
dois			k	/0002

end_final		$	/0001
dado			$	/0001
endereco		$	/0001
tamanho			$	/0001

				#	loader
