
MOUNT = java -cp ../../MLR.jar montador.MvnAsm
LINK = java -cp ../../MLR.jar linker.MvnLinker
RELOC = java -cp ../../MLR.jar relocator.MvnRelocator
RM = rm

#------------------------------------------------

reloc2: link2
	$(RELOC) T5G07A07E03-linked.mvn T5G07A07E03.mvn 0000 0000

link2: mount2-dumper mount2-main
	$(LINK) T5G07A07E03_main.mvn T5G07A07E03_dumper.mvn -s T5G07A07E03-linked.mvn

mount2-main: mount2-dumper
	$(MOUNT) T5G07A07E03_main.asm

mount2-dumper:
	$(MOUNT) T5G07A07E03_dumper.asm

clean:
	$(RM) T5G07*.lst *.mvn *.run

.PHONY: run
run:
	java -jar ../../mvn.jar
