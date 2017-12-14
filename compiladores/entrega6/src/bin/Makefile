
MOUNT = java -cp MLR.jar montador.MvnAsm
LINK = java -cp MLR.jar linker.MvnLinker
RELOC = java -cp MLR.jar relocator.MvnRelocator
RM = rm

#------------------------------------------------

# - RELOC
reloc2: link2
	$(RELOC) fatorial-linked.mvn fatorial.mvn 0000 0000
	$(RM) *.run *.lst fatorial-linked.mvn stdbirl.mvn

# - LINK
link2: mount2-main program stdbirl
	$(LINK) fatorial.mvn stdbirl.mvn -s fatorial-linked.mvn

# - MAIN
mount2-main: program
	$(MOUNT) fatorial.asm

#---------- SUB_FILES

program:
	./birlcc fatorial.brl fatorial.asm

stdbirl:
	$(MOUNT) stdbirl.asm

clean:
	$(RM) fatorial.asm *.lst *.mvn *.run

.PHONY: run
run:
	java -jar mvn.jar
