        @       /0000
MAIN    JP      PACK
A       K       /00AB
B       K       /00CD
SHIFT   K       /0100
SAIDA   $       /0001

PACK    LD      A
        *       SHIFT
        +       B
        MM      SAIDA
FIM     HM      FIM
        #       MAIN
