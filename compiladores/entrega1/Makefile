all: main

lex.yy.c: lexico.flex
	flex lexico.flex

main: lex.yy.c main.c
	g++ lex.yy.c main.c -o main

clean:
	rm main lex.yy.c
