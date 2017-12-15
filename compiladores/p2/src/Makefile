SRC = lib/uthash.h lib/utarray.h lex.yy.c gerador/code-repository.c semantico/rotinas.c semantico/semantico.c syntax/create_ape.c syntax/ape.c main.c

all: main

lex.yy.c: lexico.flex
	flex lexico.flex

syntax: syntax/generator/WIRTH.txt
	python3 -m syntax.generator

main: $(SRC)
	g++ $(SRC) -o ../bin/kipc

clean:
	rm ../bin/kipc lex.yy.c
