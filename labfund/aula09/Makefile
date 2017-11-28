
MOUNT = java -cp ../MLR.jar montador.MvnAsm
LINK = java -cp ../MLR.jar linker.MvnLinker
RELOC = java -cp ../MLR.jar relocator.MvnRelocator
RM = rm

FILE = T5G07A09E01

#------------------------------------------------

# - RELOC
reloc2: link2
	$(RELOC) $(FILE)-linked.mvn $(FILE).mvn 0000 0000

# - LINK
link2: mount2-main mount2-dumper mount2-loader mount2-rotinas mount2-const
	$(LINK) $(FILE)_main.mvn $(FILE)_dumper.mvn $(FILE)_loader.mvn $(FILE)_rotinas.mvn $(FILE)_const.mvn -s $(FILE)-linked.mvn

# - MAIN
mount2-main:
	$(MOUNT) $(FILE)_main.asm

#---------- SUB_FILES

mount2-rotinas:
	$(MOUNT) $(FILE)_rotinas.asm

mount2-loader:
	$(MOUNT) $(FILE)_loader.asm

mount2-dumper:
	$(MOUNT) $(FILE)_dumper.asm

mount2-const:
	$(MOUNT) $(FILE)_const.asm

clean:
	$(RM) T5G07*.lst *.mvn *.run

.PHONY: run
run:
	java -jar mvn.jar
