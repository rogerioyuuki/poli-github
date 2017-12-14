SRC = lib/uthash.h lib/utarray.h lex.yy.c gerador/temp-vars.c gerador/code-repository.c gerador/expression-evaluator.c gerador/code-generator.c semantico.c syntax/create_ape.c syntax/ape.c main.c

all: main

lex.yy.c: lexico.flex
	flex lexico.flex

syntax: syntax/generator/WIRTH.txt
	python3 -m syntax.generator

main: $(SRC)
	g++ -ggdb $(SRC) -o bin/birlcc

clean:
	rm bin/birlcc lex.yy.c
