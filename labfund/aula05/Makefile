MOUNT = java -cp ../MLR.jar montador.MvnAsm
LINK = java -cp ../MLR.jar linker.MvnLinker
RELOC = java -cp ../MLR.jar relocator.MvnRelocator
RM = rm

#------------------------------------------------

mount:
	$(MOUNT) testeAula07.asm

clean:
	$(RM) *.lst *.mvn *.run

.PHONY: run
run:
	java -jar mvn.jar
