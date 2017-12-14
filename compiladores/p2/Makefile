SRC = lib/uthash.h lib/utarray.h lex.yy.c syntax/create_ape.c syntax/ape.c main.c

all: main

lex.yy.c: lexico.flex
	flex lexico.flex

main: $(SRC)
	g++ -ggdb $(SRC) -o birlcc

clean:
	rm birlcc lex.yy.c
