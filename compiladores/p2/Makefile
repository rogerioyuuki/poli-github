SRC = ENTRADA.txt

all: main

main: $(SRC)
	./bin/kipc ENTRADA.txt SAIDA.j
	./kipjar SAIDA.j SAIDA.jar
	rm SAIDA.j

clean:
	rm SAIDA.j SAIDA.jar

run:
	java -noverify -jar SAIDA.jar
