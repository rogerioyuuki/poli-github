	@	/0000
MAIN	JP	MEMCPY
zahl	K	/0003
ENDIN	K	/0008
ENDOUT	K	/0010
	K	/0001
	K	/0002
	K	/0003
	K	/0004
	$	/0010		

MEMCPY	LD	zahl
	*	zwei
	MM	variable
	LD	ENDOUT 
	-	variable
	-	ENDIN  
	JN	fehler 
loop	LD	zahl
	JZ	ausDemLoop ; 40
	-	eins
	MM	zahl
	LD	ENDIN
	+	load
	MM	ersteAnweisung
	-	load
	+	zwei
	MM	ENDIN ; 50
	LD	ENDOUT
	+	save
	MM	zweiteAnweisung
	-	save
	+	zwei
	MM	ENDOUT
ersteAnweisung	$	/0001
zweiteAnweisung	$	/0001 ; 60
	JP	loop

ausDemLoop	LD null
	JP	ende
fehler	LD	funfundsechzigtausendfunfhundertfunfunddreissig
	JP	ende
null	K	/0000	; 68
eins	K	/0001
zwei	K	/0002
load	K	/8000
save	K	/9000
funfundsechzigtausendfunfhundertfunfunddreissig	K	/FFFF
variable	$	/0001

ende	HM	ende
	#	MAIN
