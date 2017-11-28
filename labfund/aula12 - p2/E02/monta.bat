java -cp MLR.jar montador.MvnAsm src/virus.asm
java -cp MLR.jar relocator.MvnRelocator src/virus.mvn E02.mvn 0000 0000
rm *.run src/*.lst src/*.mvn
PAUSE