#include "main.h"
#include "syntax/ape.h"
#include <stdio.h>

extern Token yylex();
extern FILE* yyin;


int main() {
    FILE *file;
    file = fopen("ENTRADA.txt", "r");
    yyin = file;

    APE *ape;
    ape = create_ape();

    Token token = yylex();
    while (token.type != EOF_TOKEN) {
        printf("%s - %d - %s|%d\n", ape->automatoAtual->title, ape->automatoAtual->estado, token.value, token.type);
        if (!consome_token(ape, &token)) {
            printf("\x1b[31mSyntax error at:\x1b[0m %s\n", token.value);
            break;
        }
        token = yylex();
    }

    if (token.type == EOF_TOKEN && is_ape_valid(ape)) {
        printf("\x1b[32mSyntax is valid!\x1b[0m\n");
    }
    else {
        printf("\x1b[31mSyntax is NOT valid!\x1b[0m\n");
    }

    free_ape(ape);
    fclose(file);
    return 0;
}