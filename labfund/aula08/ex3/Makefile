
MOUNT = java -cp ../../MLR.jar montador.MvnAsm
LINK = java -cp ../../MLR.jar linker.MvnLinker
RELOC = java -cp ../../MLR.jar relocator.MvnRelocator
RM = rm

FILE = T5G07A08E03

#------------------------------------------------

reloc2: link2
	$(RELOC) $(FILE)-linked.mvn $(FILE).mvn 0000 0000

link2: mount2-main
	$(LINK) $(FILE)_main.mvn $(FILE)_dumper.mvn $(FILE)_loader.mvn -s $(FILE)-linked.mvn

mount2-main: mount2-dumper mount2-loader
	$(MOUNT) $(FILE)_main.asm

mount2-loader:
	$(MOUNT) $(FILE)_loader.asm

mount2-dumper:
	$(MOUNT) $(FILE)_dumper.asm

clean:
	$(RM) T5G07*.lst *.mvn *.run

.PHONY: run
run:
	java -jar ../../mvn.jar
