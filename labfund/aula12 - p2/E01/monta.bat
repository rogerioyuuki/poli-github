java -cp MLR.jar montador.MvnAsm src/T5G14A12E01_main.asm
java -cp MLR.jar montador.MvnAsm src/somaMod11.asm
java -cp MLR.jar montador.MvnAsm src/T5G14A12E01_rotinas.asm
java -cp MLR.jar montador.MvnAsm src/T5G14A12E01_dumper.asm
java -cp MLR.jar montador.MvnAsm src/T5G14A12E01_loader.asm
java -cp MLR.jar montador.MvnAsm src/T5G14A12E01_const.asm
java -cp MLR.jar linker.MvnLinker src/T5G14A12E01_main.mvn src/somaMod11.mvn src/T5G14A12E01_rotinas.mvn src/T5G14A12E01_dumper.mvn src/T5G14A12E01_loader.mvn src/T5G14A12E01_const.mvn -s src/linked.mvn
java -cp MLR.jar relocator.MvnRelocator src/linked.mvn E01.mvn 0000 0000
rm *.run src/*.lst src/*.mvn
PAUSE