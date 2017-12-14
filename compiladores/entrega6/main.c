#include "main.h"
#include "gerador/code-repository.h"
#include "gerador/code-generator.h"
#include "syntax/ape.h"
#include <stdio.h>

extern Token yylex();
extern FILE* yyin;


int main(int argc, char *argv[]) {
    char *filePath = argv[1];
    char *outputPath = argv[2];
    if (!filePath || strlen(filePath) == 0) {
        printf(ANSI_COLOR_RED "No input" ANSI_COLOR_RESET);
    }

    if (!outputPath || strlen(outputPath) == 0) {
        printf(ANSI_COLOR_RED "No output" ANSI_COLOR_RESET);
    }

    FILE *file;
    file = fopen(filePath, "r");
    yyin = file;

    APE *ape;
    ape = create_ape();
    initCodeGenerator();

    Token token = yylex();
    while (token.type != EOF_TOKEN) {
        //printf("%s - %d - %s|%d\n", ape->automatoAtual->title, ape->automatoAtual->estado, token.value, token.type);
        if (!consome_token(ape, &token)) {
            printf("Syntax error at: %s\n", token.value);
            break;
        }
        token = yylex();
    }

    if (token.type == EOF_TOKEN && is_ape_valid(ape)) {
        printf("Syntax is valid!\n");
    }
    else {
        printf("Syntax is NOT valid!\n");
    }

    free_ape(ape);
    fclose(file);

    saveCodeToFile(outputPath);
    return 0;
}