#include "semantico.h"
#include "rotinas.h"

static inline bool isAutomato(SemanticoTrigger *trigger, const char *automato) {
    return strcmp(trigger->submaquinaAtual, automato) == 0;
}


void rotinasSemanticas(SemanticoTrigger *trigger) {
    int estadoAtual = trigger->estadoAtual, estadoProx = trigger->estadoProx;

    if (isAutomato(trigger, "KIPPLE") && estadoAtual == 0) {
        inicializacao();
    }

    if (isAutomato(trigger, "LOOP")) {
        if (estadoAtual == 1 && estadoProx == 2) comeca_loop(trigger);
        if (estadoAtual == 1 && estadoProx == 2) operando(trigger);
        if (estadoAtual == 2 && estadoProx == 4) termina_loop(trigger);
        if (estadoAtual == 3 && estadoProx == 4) termina_loop(trigger);
    }

    if (isAutomato(trigger, "ADD_SUB")) {
        if (estadoAtual == 0 && estadoProx == 1) operador_binario(trigger);
        if (estadoAtual == 1 && estadoProx == 2) operando(trigger);
        if (estadoAtual == 1 && estadoProx == 3) operando(trigger);
    }

    if (isAutomato(trigger, "PUSH_L")) {
        if (estadoAtual == 0 && estadoProx == 1) operador_binario(trigger);
        if (estadoAtual == 1 && estadoProx == 2) operando(trigger);
        if (estadoAtual == 1 && estadoProx == 3) operando(trigger);
    }

    if (isAutomato(trigger, "PUSH_R")) {
        if (estadoAtual == 0 && estadoProx == 1) operador_binario(trigger);
        if (estadoAtual == 1 && estadoProx == 2) operando(trigger);
    }

    if (isAutomato(trigger, "EXPRESSION")) {
        if (estadoAtual == 2 && estadoProx == 4) operador_binario(trigger);
        if (estadoAtual == 0 && estadoProx == 1) operando(trigger);
        if (estadoAtual == 0 && estadoProx == 2) operando(trigger);
        if (estadoAtual == 4 && estadoProx == 5) operando(trigger);
    }

    if (isAutomato(trigger, "CLEAR")) {
        if (estadoAtual == 0 && estadoProx == 1) clear(trigger);
    }
}


void semantico(Automato *automato, Token *token, Transicao *transicao) {
    SemanticoTrigger *trigger = (SemanticoTrigger*)malloc(sizeof(SemanticoTrigger));
    trigger->token = token;
    trigger->submaquinaAtual = automato->title;
    trigger->submaquinaProx = automato->title;
    trigger->estadoAtual = automato->estado;
    trigger->estadoProx = transicao->estadoResultado;

    //printf(ANSI_COLOR_BLUE "%s %d -> %s %d (%s)\n" ANSI_COLOR_RESET, trigger->submaquinaAtual, trigger->estadoAtual, trigger->submaquinaProx, trigger->estadoProx, token->value);

    rotinasSemanticas(trigger);
    free(trigger);
}

void semantico_submaquina(Automato *automato, Token *token, TransicaoChamada *chamada) {
    SemanticoTrigger *trigger = (SemanticoTrigger*)malloc(sizeof(SemanticoTrigger));
    trigger->token = token;
    trigger->submaquinaAtual = automato->title;
    trigger->estadoAtual = automato->estado;

    switch (token->type) {
        case NUMBER:
        case STACK_IDENTIFIER:
            trigger->submaquinaProx = automato->title;
            trigger->estadoProx = chamada->estadoResultado;
            break;
        default:
            trigger->submaquinaProx = chamada->submaquina;
            trigger->estadoProx = 0;
            break;
    }


    //printf(ANSI_COLOR_BLUE "%s %d -> %s %d (%s)\n" ANSI_COLOR_RESET, trigger->submaquinaAtual, trigger->estadoAtual, trigger->submaquinaProx, trigger->estadoProx, token->value);

    rotinasSemanticas(trigger);
    free(trigger);
}

void semantico_desempilha(Automato *automato, Token *token, APE *ape) {
    SemanticoTrigger *trigger = (SemanticoTrigger*)malloc(sizeof(SemanticoTrigger));
    trigger->token = token;
    trigger->submaquinaAtual = automato->title;
    trigger->submaquinaProx = ape->automatoAtual->title;
    trigger->estadoAtual = automato->estado;
    trigger->estadoProx = ape->automatoAtual->estado;

    //printf(ANSI_COLOR_BLUE "%s %d -> %s %d (%s)\n" ANSI_COLOR_RESET, trigger->submaquinaAtual, trigger->estadoAtual, trigger->submaquinaProx, trigger->estadoProx, token->value);

    rotinasSemanticas(trigger);
    free(trigger);
}
