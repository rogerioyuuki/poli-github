#include "main.h"
#include <stdio.h>

extern Token yylex();
extern FILE* yyin;


int main() {
    char const *enumTypes[] = {"IDENTIFIER", "INTEGER", "DECIMAL", "STRING", "KEYWORD", "SYMBOL", "EOF_TOKEN"};

    FILE *file;
    file = fopen("lexico.teste", "r");
    yyin = file;

    Token token = yylex();
    while(token.type != EOF_TOKEN){
        printf("Token %s - %s\n", enumTypes[token.type], token.value);
        token = yylex();
    }

    fclose(file);
    return 0;
}