#include "semantico.h"
#include "gerador/code-generator.h"

void semantico(Automato *automato, Token *token, Transicao *transicao) {
    CodeGeneratorTransition *transition = (CodeGeneratorTransition*)malloc(sizeof(CodeGeneratorTransition));
    transition->token = token;
    transition->submaquinaAtual = automato->title;
    transition->submaquinaProx = automato->title;
    transition->estadoAtual = automato->estado;
    transition->estadoProx = transicao->estadoResultado;
    consumeTransition(transition);
    free(transition);
}

void semantico_submaquina(Automato *automato, Token *token, TransicaoChamada *chamada) {
    CodeGeneratorTransition *transition = (CodeGeneratorTransition*)malloc(sizeof(CodeGeneratorTransition));
    transition->token = token;
    transition->submaquinaAtual = automato->title;
    transition->submaquinaProx = chamada->submaquina;
    transition->estadoAtual = automato->estado;
    transition->estadoProx = 0;
    consumeTransition(transition);
    free(transition);
}

void semantico_desempilha(Automato *automato, Token *token, APE *ape) {
    CodeGeneratorTransition *transition = (CodeGeneratorTransition*)malloc(sizeof(CodeGeneratorTransition));
    transition->token = token;
    transition->submaquinaAtual = automato->title;
    transition->submaquinaProx = ape->automatoAtual->title;
    transition->estadoAtual = automato->estado;
    transition->estadoProx = ape->automatoAtual->estado;
    consumeTransition(transition);
    free(transition);
}
