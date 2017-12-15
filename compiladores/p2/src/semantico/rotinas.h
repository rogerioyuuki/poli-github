#ifndef ROTINAS_H
#define ROTINAS_H 1

#include "semantico.h"

void inicializacao();
void finalizacao();
void comeca_loop(SemanticoTrigger *trigger);
void termina_loop(SemanticoTrigger *trigger);
void operador_binario(SemanticoTrigger *trigger);
void operando(SemanticoTrigger *trigger);
void push_l(SemanticoTrigger *trigger);
void push_r(SemanticoTrigger *trigger);
void add_sub(SemanticoTrigger *trigger);
void clear(SemanticoTrigger *trigger);

#endif

