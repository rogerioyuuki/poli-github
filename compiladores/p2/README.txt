COMPILADOR
------------------------
Instrução de compilação:

0) Entrar na pasta src/
1) Ter 'flex' instalado na máquina
2) Rodar python3 -m syntax.generator (OPCIONAL)
3) Executar o Makefile ('make')


RUNTIME
--------------------------
O KRE (Kipple Runtime Engine) é um projeto Java na pasta jvm/kre/src

Utilizei o intellij IDEA para compilar suas classes em .class.
Após o compilador gerar a classe Main, os arquivos são juntados em um .jar para execução.


EXECUÇÂO
--------------------------
Instrução de execução

O compilador é gerado na pasta bin/

1) Compilar seu programa Kipple com o comando: './bin/kipc <input> <output.j>'.
2) Gerar um .jar, executando o programa './kipjar <input.j> <output.jar>' utilizando o bytecode como input.
3) Executar o .jar com: 'java -noverify -jar <input.jar>'


ALTERNATIVA c/ Makefile
-------------------------
O Makefile na pasta raiz compila o arquivo ENTRADA.txt para uma SAIDA.jar
Rodar o jar com -noverify

1) 'make'
2) 'make run'