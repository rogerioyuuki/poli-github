& /0000
; chtoi
chtoi-A1    <
chtoi-A2    <
chtoi-OUT   <
chtoi       <
argumentos-erro <
espaco-bb-char <
get-char <
UM <
DOIS <
NEGATIVO <
EOL <
EOL-CR <
EOL-LF <
readbyte <

SOMAMOD11 	>
SOMAMOD11_UL >

; Parâmetros da subrotina
SOMAMOD11_UL	K	/0000 ; unidade lógica onde está o arquivo de batch (donde será lida a entrada do usuário)
; ^ nao utilizada!! a UL usada esta no arquivo MAIN!!
; Buffer da subrotina
BUFFER	$	=0010	; buffer com 10 palavras
; Corpo da subrotina
SOMAMOD11	K	/0000	; entrada da subrotina

;----------------------------------------------------------------
;----- Coloque aqui seu código para ler todos os parâmetros -----
;---- presentes no arquivo e colocar no buffer, de cima para ----
;------ baixo. NÃO verifique se a entrada cabe no buffer. -------
;----------------------------------------------------------------

; BASEADO NO COMANDO CL

             LV =0
             MM cont
             MM temp

             LD SAVE-BUFFER-instr
             MM SAVE-BUFFER

             ; loop {
; CHECAGEM DE TAMANHO - DESCOMENTAR SE PRECISO
; MEU CL CHECAVA O TAMANHO, MAS ESTE BUFFER PRECISA SER VULNERÁVEL
;loop         LD cont
;             - max
;             JZ argumentos-erro

loop         SC readbyte
             MM chtoi-A1
             SC readbyte
             MM chtoi-A2
             SC chtoi
             - NEGATIVO
             JZ argumentos-erro
             LD chtoi-OUT
SAVE-BUFFER  MM BUFFER
          
          ; INCREMENTA
             
             LD SAVE-BUFFER
             + DOIS
             MM SAVE-BUFFER


             LD cont
             + UM
             MM cont

          ; Checa EOL ou prox arg
             SC get-char
             MM temp

             - espaco-bb-char
             JZ next-param
             
             LD temp
             - EOL-CR
             JZ EOL-argumentos

             LD temp
             - EOL-LF
             JZ SOMAMOD11_CALCULA
             JP argumentos-erro

             ; }

next-param    SC get-char
              - espaco-bb-char
              JZ loop
              JP argumentos-erro

EOL-argumentos SC EOL
               JP SOMAMOD11_CALCULA

SAVE-BUFFER-instr MM BUFFER
temp K =0
cont K =0 ; words passadas
max K /000A ; máximo - nao usado

;----------------------------------------------------------------
;------- Coloque aqui seu código para calcular a soma dos -------
;----- módulo 11 dos dados do buffer, colocando o resultado -----
;--- no acumulador. Para facilitar a correção, a última linha ---
;---- do código também está escrevendo o resultado na posição ---
;----------- 0FFE da memória, então mantenha assim. -------------
;----------------------------------------------------------------

SOMAMOD11_CALCULA LV =0
                  MM soma_cont
                  MM soma_temp

                  LD soma_dado_instr
                  MM soma_dado_buffer ; RESET das variaveis

                  ; LOOP:
soma_loop         LD soma_cont
                  - cont
                  JZ mod_calcula

                  LD soma_temp
soma_dado_buffer  + BUFFER
                  MM soma_temp

                  LD soma_dado_buffer
                  + DOIS
                  MM soma_dado_buffer

                  LD soma_cont
                  + UM
                  MM soma_cont

                  JP soma_loop



soma_dado_instr + BUFFER
soma_cont $ =1
soma_temp $ =1
; =========================================
; programa pula pra ca depois de somar tudo
;==========================================
mod_calcula LD soma_temp
            / ONZE
            * ONZE
            MM mod_temp

            LD soma_temp
            - mod_temp
; OU SEJA:
; ==========================================
; | SOMAMOD11 = SOMA - (floor(SOMA/11))*11 |
; ==========================================
	MM	/0FFE		; (NÃO MODIFIQUE: coloca o resultado na posição 0FFE da memória)
	RS	SOMAMOD11	; fim da subrotina


mod_temp $ =1
ONZE K =11

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
