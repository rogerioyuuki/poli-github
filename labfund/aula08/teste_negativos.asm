		&	/0000

main	jp	inicio

x		k	/
y		k	/

inicio	ld	x
		-	y
		jn	negw
		jp	pos

neg		ld	/ffff
		jp	end
pos		ld	/0000

end		hm	end

		#	main