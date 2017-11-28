LOADER_UL 	<
LOADER		<
dump_ini	<
dump_tam	<
dump_ul		<
dumper		<

;========================= NÃO ALTERE ESTE TRECHO: INÍCIO ===================;
& /0000
MAIN			JP	START	; Salta para início do main

; PARAMETROS
UL_TEST			K	/0002	; Unidade logica do disco a ser usado

;========================== NÃO ALTERE ESTE TRECHO: FIM =====================;

dump_ini_var	k	/0400
dump_tam_var	k	/0007
dump_ul_var		k	/0000

START			LD	UL_TEST
				MM	LOADER_UL	; Invoca loader
				ld	dump_ini_var
				mm	dump_ini
				ld	dump_tam_var
				mm	dump_tam
				ld	dump_ul_var
				mm	dump_ul

				;sc	dumper
				SC 	LOADER		
FIM_MAIN		HM	FIM_MAIN	; Fim do main

# MAIN