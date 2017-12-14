#ifndef SEMANTICO_H
#define SEMANTICO_H 1

#include "syntax/ape.h"

typedef struct {
  Token *token;
  const char *submaquinaAtual;
  const char *submaquinaProx;
  int estadoAtual;
  int estadoProx;
} CodeGeneratorTransition;

void semantico(Automato *automato, Token *token, Transicao *transicao);
void semantico_submaquina(Automato *automato, Token *token, TransicaoChamada *chamada);
void semantico_desempilha(Automato *automato, Token *token, APE *ape);

#endif

