& /0000

SOMAMOD11 	>
SOMAMOD11_UL >

; Par�metros da subrotina
SOMAMOD11_UL	K	/0000 ; unidade l�gica onde est� o arquivo de batch (donde ser� lida a entrada do usu�rio)
; Buffer da subrotina
BUFFER	$	=0010	; buffer com 10 palavras
; Corpo da subrotina
SOMAMOD11	K	/0000	; entrada da subrotina

;----------------------------------------------------------------
;----- Coloque aqui seu c�digo para ler todos os par�metros -----
;---- presentes no arquivo e colocar no buffer, de cima para ----
;------ baixo. N�O verifique se a entrada cabe no buffer. -------
;----------------------------------------------------------------

;----------------------------------------------------------------
;------- Coloque aqui seu c�digo para calcular a soma dos -------
;----- m�dulo 11 dos dados do buffer, colocando o resultado -----
;--- no acumulador. Para facilitar a corre��o, a �ltima linha ---
;---- do c�digo tamb�m est� escrevendo o resultado na posi��o ---
;----------- 0FFE da mem�ria, ent�o mantenha assim. -------------
;----------------------------------------------------------------


	MM	/0FFE		; (N�O MODIFIQUE: coloca o resultado na posi��o 0FFE da mem�ria)
	RS	SOMAMOD11	; fim da subrotina

# SOMAMOD11	
; LEMBRETE:
;==== Para a execu��o do montador
; java -cp MLR.jar montador.MvnAsm [<arquivo asm>]
; Exemplo: java -cp MLR.jar montador.MvnAsm  test.asm

;==== Para a execu��o do linker
; java -cp MLR.jar linker.MvnLinker <arquivo-objeto1> <arquivo-objeto2> ... <arquivo-objetoN> -s <arquivo-saida>
; Exemplo: java -cp MLR.jar linker.MvnLinker prog1.mvn prog2.mvn �s test.mvn
; Obs.: coloque a fun��o main como primeiro argumento (isso facilita a execu��o, pois a primeira instru��o do programa ligado ser� do main)

;==== Para a execu��o do relocador
; java -cp MLR.jar relocator.MvnRelocator <arquivo-objeto> <arquivo-saida> <base-reloca��o> <endere�o-inicio-execu��o>
; Exemplo: java -cp MLR.jar relocator.MvnRelocator  test.mvn final.mvn 0000 000

;==== Para a execu��o da MVN. OBS.: pode-se tamb�m executar via Netbeans/Eclipse, colocando os arquivos na pasta de projeto (a mesma que tem a pasta "src")
; java -jar mvn.jar
; Obs.: Se houver problemas com caracteres especiais, use:
; java -Dfile.encoding=cp850 -jar mvn.jar
