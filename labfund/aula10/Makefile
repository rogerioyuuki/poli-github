
MOUNT = java -cp ../MLR.jar montador.MvnAsm
LINK = java -cp ../MLR.jar linker.MvnLinker
RELOC = java -cp ../MLR.jar relocator.MvnRelocator
RM = rm

FILE = T5G07A10E01

#------------------------------------------------

# - RELOC
reloc2: link2
	$(RELOC) src/$(FILE)-linked.mvn $(FILE).mvn 0000 0000
	$(RM) *.run src/T5G07*.lst src/*.mvn

# - LINK
link2: mount2-main mount2-dumper mount2-loader mount2-rotinas mount2-const
	$(LINK) src/$(FILE)_main.mvn src/$(FILE)_dumper.mvn src/$(FILE)_loader.mvn src/$(FILE)_rotinas.mvn src/$(FILE)_const.mvn -s src/$(FILE)-linked.mvn

# - MAIN
mount2-main:
	$(MOUNT) src/$(FILE)_main.asm

#---------- SUB_FILES

mount2-rotinas:
	$(MOUNT) src/$(FILE)_rotinas.asm

mount2-loader:
	$(MOUNT) src/$(FILE)_loader.asm

mount2-dumper:
	$(MOUNT) src/$(FILE)_dumper.asm

mount2-const:
	$(MOUNT) src/$(FILE)_const.asm

clean:
	$(RM) T5G07*.lst *.mvn *.run

.PHONY: run
run:
	java -jar mvn.jar
