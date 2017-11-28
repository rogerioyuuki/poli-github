        @       /0000
MAIN    JP      PACK
A       K       /00AB
B       K       /00CD
SAIDA   $       /0001
SHIFT	K	/0100

PACK    LD      A
        *       SHIFT
        +       B
        MM      SAIDA
FIM     HM      FIM
        #       MAIN
