; PACK
	a	<
	b	<
	pack	<

; UNPACK
	in	<
	unpack1 <
	unpack2	<
	unpack	<

; STRCMP
	str1	<
	str2	<
	out	<
	strcmp	<

	&	/0000

main	JP	inicio

valora	K	/0010
valorb	K	/0064
valorpack $	/0001

valorin	K	/1234
valorunpack1 $	/0001
valorunpack2 $	/0001

valorstr1 K	'va
	K	'ic
	K	'oa
	K	/6600
	K	/0000
	K	/0000
	K	/0000
	K	/0000
valorstr2 K	'va
	K	'ic
	K	'oa
	K	/6600
	K	/0000
        K       /0000
        K       /0000
        K       /0000
valorout $	/0001

inicio	LD	valora ; 30
	MM	a ; 32
	LD	valorb ; 34
	MM	b ; 36
	SC	pack ; 38
	MM	valorpack ; 3A

	LD	valorin ; 3C
	MM	in ; 3E
	SC	unpack ; 40
	LD	unpack1 ; 42
	MM	valorunpack1 ; 44
	LD	unpack2 ; 46
	MM	valorunpack2 ; 48

end	HM	end
	#	main
