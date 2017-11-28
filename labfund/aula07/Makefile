
MOUNT = java -cp ../MLR.jar montador.MvnAsm
LINK = java -cp ../MLR.jar linker.MvnLinker
RELOC = java -cp ../MLR.jar relocator.MvnRelocator
RM = rm

#------------------------------------------------

reloc2: link2
	$(RELOC) T5G07A07E02-linked.mvn T5G07A07E02.mvn 0000 0000

link2: mount2-dumper mount2-main mount2-const
	$(LINK) T5G07A07E02_main.mvn T5G07A07E02_dumper.mvn T5G07A07E02_const.mvn -s T5G07A07E02-linked.mvn

mount2-dumper: mount2-dumper
	$(MOUNT) T5G07A07E02_dumper.asm

mount2-main: mount2-main
	$(MOUNT) T5G07A07E02_main.asm

mount2-const: mount2-const
	$(MOUNT) T5G07A07E02_const.asm

clean:
	$(RM) *.lst *.mvn *.run

.PHONY: run
run:
	java -jar ../mvn.jar
