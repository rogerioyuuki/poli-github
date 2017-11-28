
MOUNT = java -cp ../MLR.jar montador.MvnAsm
LINK = java -cp ../MLR.jar linker.MvnLinker
RELOC = java -cp ../MLR.jar relocator.MvnRelocator
RM = rm

#------------------------------------------------

reloc2: link2
	$(RELOC) T5G07A03E02-linked.mvn T5G07A03E02.mvn 0000 0000

link2: mount2-rotinas mount2-main mount2-const
	$(LINK) T5G07A03E02_main.mvn T5G07A03E02_rotinas.mvn T5G07A03E02_const.mvn -s T5G07A03E02-linked.mvn

mount2-rotinas: mount2-const
	$(MOUNT) T5G07A03E02_rotinas.asm

mount2-main: mount2-rotinas
	$(MOUNT) T5G07A03E02_main.asm

mount2-const:
	$(MOUNT) T5G07A03E02_const.asm

clean:
	$(RM) *.lst *.mvn *.run

.PHONY: run
run:
	java -jar ../mvn.jar
