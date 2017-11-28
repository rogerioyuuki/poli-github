; Import
; Dumper
DUMPER      < 
DUMP_INI    <
DUMP_TAM    <
DUMP_UL     <
DUMP_BL     <
DUMP_EXE    <
; Loader
LOADER      <
LOADER_UL   <
; chtoi
chtoi-A1    <
chtoi-A2    <
chtoi-OUT   <
chtoi       <
;itoch
itoch-A     <
itoch-OUT1  <
itoch-OUT2  <
itoch       <
; UNPACK
UNPACK-A    <
UNPACK-OUT1 <
UNPACK-OUT2 <
UNPACK      <
; PACK
PACK-A      <
PACK-B      <
PACK-OUT    <
PACK        <
; Consts
UM <            ; /0001
DOIS <          ; /0002
NEGATIVO <      ; /FFFF
DEZ <           ; /000A
SHIFT  <        ; /0010
CHAR-0 <        ; /0030
CHAR-9 <        ; /0039
CHAR-A <        ; /0041
CHAR-F <        ; /0046
A-F-CONVERTER < ; /0037



& 	/0000

MAIN	JP 	INI		; salta para o início do programa
UL		K 	/0000 	; parâmetro: UL onde está o arquivo de batch

; configura UL do batch.txt
INI		LD UL
      + readbyte-instr
      MM readbyte-instr

      SC inicio-JB
MAIN_PROCESS  SC detect

END_BATCH LV /0000
          OS /00EE

FIM 	HM	FIM		; fim do programa

; ======================
; Sub-rotinas para BATCH
; ======================

; inicio-JB
; Detecta o inicio //JB
inicio-JB       $ =1
; initial reset
                LD inicio-JB-instr
                MM inicio-JB-check
                LV =0
                MM inicio-JB-cont
; LOOP
inicio-JB-loop  LV =4
                - inicio-JB-cont
                JZ inicio-JB-fim
; {
              ; setup text pointer
                LD inicio-JB-check
                + DOIS
                MM inicio-JB-check
              ; setup counter
                LD inicio-JB-cont
                + UM
                MM inicio-JB-cont

                SC get-char
inicio-JB-check - inicio-JB-text
                JZ inicio-JB-loop
                JP inicio-JB-erro
; }
inicio-JB-fim   SC EOL
                JN inicio-JB-erro
                RS inicio-JB

inicio-JB-erro LV /0001
               OS /00EE
               JP FIM

inicio-JB-instr - inicio-JB-text
inicio-JB-cont K =0
inicio-JB-text $ =1
               K /002F
               K /002F
               K /004A
               K /0042

; Sub-rotina
; detect
; detecta o comando ou fim
detect $ =1
       SC get-char
       - detect-barra
       JZ detect-continue
       JP detect-erro

detect-continue SC get-char
                MM detect-temp
                - detect-estrela
                JZ END_BATCH
                JP detect-before-comando

detect-before-comando LD detect-temp
                      - detect-barra
                      JZ detect-comando
                      JP detect-erro

detect-comando SC get-char
               MM detect-temp
               - detect-L
               JZ detect-LO
               JP detect-checa-D

detect-checa-D LD detect-temp
               - detect-D
               JZ detect-DU
               JP detect-erro

detect-LO LV /0000 ; /0000 = LO
          MM detect-temp ; /FFFF = DU
          SC get-char
          - detect-O
          JZ detect-EOL
          JP detect-erro

detect-DU LD NEGATIVO ; /0000 = LO
          MM detect-temp ; /FFFF = DU
          SC get-char
          - detect-U
          JZ detect-EOL
          JP detect-erro

detect-EOL SC EOL
           JN detect-erro
           LD detect-temp
           JZ argumento-LO
           JN argumento-DU
           JP detect-erro


detect-erro LV /0002
            OS /00EE
            JP FIM


detect-temp $ =1

detect-barra K /002F
detect-L K /004C
detect-O K /004F
detect-D K /0044
detect-U K /0055
detect-estrela K /002A


; argumento-LO
; Le os argumentos do LO
argumento-LO SC readbyte
              MM chtoi-A1
              SC readbyte
              MM chtoi-A2
              SC chtoi
              - NEGATIVO
              JZ argumentos-erro
              LD chtoi-OUT
              MM LOADER_UL

              SC EOL
              JN argumentos-erro

              SC LOADER
              JP MAIN_PROCESS
              

; Sub-rotina argumento-DU
; Le os argumentos do DU
; primeiro argumento: DUMP_BL
argumento-DU SC readbyte
              MM chtoi-A1
              SC readbyte
              MM chtoi-A2
              SC chtoi
              - NEGATIVO
              JZ argumentos-erro
              LD chtoi-OUT
              MM DUMP_BL
              ; bb
              SC espaco-bb
; segundo argumento: DUMP_INI
              SC readbyte
              MM chtoi-A1
              SC readbyte
              MM chtoi-A2
              SC chtoi
              - NEGATIVO
              JZ argumentos-erro
              LD chtoi-OUT
              MM DUMP_INI
              ; bb
              SC espaco-bb
; terceiro argumento: DUMP_TAM
              SC readbyte
              MM chtoi-A1
              SC readbyte
              MM chtoi-A2
              SC chtoi
              - NEGATIVO
              JZ argumentos-erro
              LD chtoi-OUT
              MM DUMP_TAM
              ; bb
              SC espaco-bb
; quarto argumento: DUMP_EXE
              SC readbyte
              MM chtoi-A1
              SC readbyte
              MM chtoi-A2
              SC chtoi
              - NEGATIVO
              JZ argumentos-erro
              LD chtoi-OUT
              MM DUMP_EXE
              ; bb
              SC espaco-bb
; quinto argumento: DUMP_UL
              SC readbyte
              MM chtoi-A1
              SC readbyte
              MM chtoi-A2
              SC chtoi
              - NEGATIVO
              JZ argumentos-erro
              LD chtoi-OUT
              MM DUMP_UL

              SC EOL
              JN argumentos-erro

              SC DUMPER
              JP MAIN_PROCESS



argumentos-erro LV /0003
                OS /00EE
                JP FIM

; Sub-rotina espaco-bb
espaco-bb $ =1
          SC get-char
          - espaco-bb-char
          JZ espaco-bb-2
          JP argumentos-erro
espaco-bb-2 SC get-char
            - espaco-bb-char
            JZ espaco-bb-fim
            JP argumentos-erro

espaco-bb-fim  LV /0000
               RS espaco-bb

espaco-bb-temp $ =1
espaco-bb-char K /0020

; Sub-rotina EOL
EOL $ =1
    SC get-char
    MM EOL-temp
    - EOL-LF
    JZ EOL-fim
    LD EOL-temp
    - EOL-CR
    JZ EOL-cont
    JP EOL-erro
EOL-cont SC get-char
         - EOL-LF
         JZ EOL-fim
         JP EOL-erro

EOL-fim  LV /0000
         RS EOL
EOL-erro LD NEGATIVO
         RS EOL

EOL-temp $ =1
EOL-CR K /000D
EOL-LF K /000A

; get-char
; Carrega no AC, um caractere do arquivo
; Detecta erro de fim de arquivos
; Ex: get-char -> /0030

get-char $ =1
         SC readchar
         MM get-char-temp
         - get-char-endoffile
         JZ get-char-error
         LD get-char-temp
         RS get-char

get-char-error LV /0004
               OS /00EE
               JP FIM

get-char-temp $ =1
get-char-endoffile K /00FF

; readchar
; Carrega no AC, um caractere do arquivo
; Ex: get-char -> /0030

readchar    $ =1
            LD readchar-state
            JZ readchar-load
            ; state = 0
            LV =0
            MM readchar-state
            SC readbyte
            MM UNPACK-A
            SC UNPACK
            LD UNPACK-OUT2
            MM readchar-temp
            LD UNPACK-OUT1
            RS readchar

readchar-load LD NEGATIVO ; state = /FFFF
              MM readchar-state
              LD readchar-temp
              RS readchar

; /FFFF -> do GD
; /0000 -> read readchar-temp
readchar-state K /FFFF
readchar-temp  $ =1

; readbyte
; equivlente a GD
readbyte $ =1
readbyte-instr GD /0300
          RS readbyte


# MAIN