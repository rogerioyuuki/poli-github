& /0000

SOMAMOD11 	>
SOMAMOD11_UL >

; Parâmetros da subrotina
SOMAMOD11_UL	K	/0000 ; unidade lógica onde está o arquivo de batch (donde será lida a entrada do usuário)
; Buffer da subrotina
BUFFER	$	=0010	; buffer com 10 palavras
; Corpo da subrotina
SOMAMOD11	K	/0000	; entrada da subrotina

;----------------------------------------------------------------
;----- Coloque aqui seu código para ler todos os parâmetros -----
;---- presentes no arquivo e colocar no buffer, de cima para ----
;------ baixo. NÃO verifique se a entrada cabe no buffer. -------
;----------------------------------------------------------------

;----------------------------------------------------------------
;------- Coloque aqui seu código para calcular a soma dos -------
;----- módulo 11 dos dados do buffer, colocando o resultado -----
;--- no acumulador. Para facilitar a correção, a última linha ---
;---- do código também está escrevendo o resultado na posição ---
;----------- 0FFE da memória, então mantenha assim. -------------
;----------------------------------------------------------------


	MM	/0FFE		; (NÃO MODIFIQUE: coloca o resultado na posição 0FFE da memória)
	RS	SOMAMOD11	; fim da subrotina

# SOMAMOD11	
; LEMBRETE:
;==== Para a execução do montador
; java -cp MLR.jar montador.MvnAsm [<arquivo asm>]
; Exemplo: java -cp MLR.jar montador.MvnAsm  test.asm

;==== Para a execução do linker
; java -cp MLR.jar linker.MvnLinker <arquivo-objeto1> <arquivo-objeto2> ... <arquivo-objetoN> -s <arquivo-saida>
; Exemplo: java -cp MLR.jar linker.MvnLinker prog1.mvn prog2.mvn –s test.mvn
; Obs.: coloque a função main como primeiro argumento (isso facilita a execução, pois a primeira instrução do programa ligado será do main)

;==== Para a execução do relocador
; java -cp MLR.jar relocator.MvnRelocator <arquivo-objeto> <arquivo-saida> <base-relocação> <endereço-inicio-execução>
; Exemplo: java -cp MLR.jar relocator.MvnRelocator  test.mvn final.mvn 0000 000

;==== Para a execução da MVN. OBS.: pode-se também executar via Netbeans/Eclipse, colocando os arquivos na pasta de projeto (a mesma que tem a pasta "src")
; java -jar mvn.jar
; Obs.: Se houver problemas com caracteres especiais, use:
; java -Dfile.encoding=cp850 -jar mvn.jar
