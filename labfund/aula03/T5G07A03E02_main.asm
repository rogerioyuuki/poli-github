& /0000
JP inicio
; chtoi
chtoi-1 K 'A4
chtoi-2 K 'A0
chtoi-saida $ =1
; itoch
itoch-1 K /A1B2
itoch-saida1 $ =1
itoch-saida2 $ =1

; importação de rotinas
chtoi-A1 <
chtoi-A2 <
chtoi-OUT <
chtoi <

itoch-A <
itoch-OUT1 <
itoch-OUT2 <
itoch <

; programa
inicio LD chtoi-1
	MM chtoi-A1
	LD chtoi-2
	MM chtoi-A2
	SC chtoi
	LD chtoi-OUT
	MM chtoi-saida

	LD itoch-1
	MM itoch-A
	SC itoch
	LD itoch-OUT1
	MM itoch-saida1
	LD itoch-OUT2
	MM itoch-saida2

fim HM fim

# main