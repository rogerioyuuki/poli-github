#include "../lib/utarray.h"
#include "../gerador/code-repository.h"
#include "semantico.h"
#include "rotinas.h"
#include "../main.h"

int L_counter = 0;

Token *operandoEsquerdo = NULL, *operador = NULL, *operandoDireito = NULL;

int Loop_counter = 0;
UT_array *loopLabels = NULL;

void addMainCode(const char * line) {
    char *buf = (char*)smart_malloc((30 + strlen(line)) * sizeof(char));
    sprintf(buf, "L%d:    %s", L_counter++, line);
    addCode(buf);
    free(buf);
}

char *formatStackInstruction(const char *instr, const char *operand) {
    char *buf = (char*)smart_malloc((20 + strlen(instr)) * sizeof(char));
    sprintf(buf, "%s %d", instr, (int) *operand);
    return buf;
}

char *formatNumberInstruction(const char *instr, const char *operand) {
    char *buf = (char*)smart_malloc((20 + strlen(instr)) * sizeof(char));
    sprintf(buf, "%s %s", instr, operand);
    return buf;
}

int getStackId(Token *token) {
    return (int)*token->value;
}

void inicializacao() {
    addCode(".version 52 0 ");
    addCode(".class public super Main ");
    addCode(".super java/lang/Object ");
    addCode("");
    addCode(".method public <init> : ()V ");
    addCode("    .code stack 1 locals 1 ");
    addCode("L0:     aload_0 ");
    addCode("L1:     invokespecial Method java/lang/Object <init> ()V ");
    addCode("L4:     return ");
    addCode("L5:     ");
    addCode("        .linenumbertable ");
    addCode("            L0 3 ");
    addCode("        .end linenumbertable ");
    addCode("        .localvariabletable ");
    addCode("            0 is this LMain; from L0 to L5 ");
    addCode("        .end localvariabletable ");
    addCode("    .end code ");
    addCode(".end method ");
    addCode("");
    addCode(".method public static main : ([Ljava/lang/String;)V ");
    addCode("    .code stack 2 locals 1 ");
    addMainCode("aload_0");
    addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime init ([Ljava/lang/String;)V");
}

void finalizacao() {
    addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime printOutput ()V");
    addMainCode("return");
    addCode("    .end code");
    addCode(".end method");
    addCode(".sourcefile 'Main.java'");
    addCode(".end class");
}

void comeca_loop(SemanticoTrigger *trigger) {
    if (loopLabels == NULL) utarray_new(loopLabels, &ut_int_icd);

    int thisLoop = Loop_counter;
    utarray_push_back(loopLabels, &thisLoop);

    char *buf = (char*)smart_malloc((50) * sizeof(char));
    sprintf(buf, "LOOP%d_START:    bipush %d", thisLoop, getStackId(trigger->token));
    addCode(buf);
    free(buf);

    addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime isEmpty (I)I");
    buf = (char*)smart_malloc((50) * sizeof(char));
    sprintf(buf, "ifgt LOOP%d_END", thisLoop);
    addMainCode(buf);
    free(buf);
    
    Loop_counter++;
}

void termina_loop(SemanticoTrigger *trigger) {
    int thisLoop = (int) *utarray_back(loopLabels);
    utarray_pop_back(loopLabels);

    char *buf = (char*)smart_malloc((50) * sizeof(char));
    sprintf(buf, "goto LOOP%d_START", thisLoop);
    addMainCode(buf);
    free(buf);

    buf = (char*)smart_malloc((25) * sizeof(char));
    sprintf(buf, "LOOP%d_END:    nop", thisLoop);
    addCode(buf);
    free(buf);
}

void operador_binario(SemanticoTrigger *trigger) {
    operador = (Token*) smart_malloc(sizeof(Token));
    operador->type = trigger->token->type;
    operador->value = trigger->token->value;
}

void operando(SemanticoTrigger *trigger) {
    free(operandoEsquerdo);
    operandoEsquerdo = operandoDireito;
    operandoDireito = (Token*) smart_malloc(sizeof(Token));
    operandoDireito->type = trigger->token->type;
    operandoDireito->value = trigger->token->value;

    if (operador != NULL && strcmp(operador->value, "<") == 0) {
        push_l(trigger);
    }
    else if (operador != NULL && strcmp(operador->value, ">") == 0) {
        push_r(trigger);
    }
    else if (operador != NULL && strcmp(operador->value, "+") == 0) {
        add_sub(trigger);
    }
    else if (operador != NULL && strcmp(operador->value, "-") == 0) {
        add_sub(trigger);
    }
}

void push_l(SemanticoTrigger *trigger) {
    addMainCode( formatStackInstruction("bipush", operandoEsquerdo->value) );

    switch (operandoDireito->type) {
        case NUMBER:
            addMainCode( formatNumberInstruction("bipush", operandoDireito->value) );
            addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime push (II)V");
            break;
        case STACK_IDENTIFIER:
            addMainCode( formatStackInstruction("bipush", operandoDireito->value) );
            addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime pop (I)I");
            addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime push (II)V");
            break;
    }
    free(operador); operador = NULL;
}

void push_r(SemanticoTrigger *trigger) {
    addMainCode( formatStackInstruction("bipush", operandoDireito->value) );

    switch (operandoEsquerdo->type) {
        case NUMBER:
            addMainCode( formatNumberInstruction("bipush", operandoEsquerdo->value) );
            addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime push (II)V");
            break;
        case STACK_IDENTIFIER:
            addMainCode( formatStackInstruction("bipush", operandoEsquerdo->value) );
            addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime pop (I)I");
            addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime push (II)V");
            break;
    }
    free(operador); operador = NULL;
}

void add_sub(SemanticoTrigger *trigger) {
    addMainCode( formatStackInstruction("bipush", operandoEsquerdo->value) );

    if (strcmp(operador->value, "+") == 0) {
        switch (operandoDireito->type) {
            case NUMBER:
                addMainCode( formatNumberInstruction("bipush", operandoDireito->value) );
                addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime add (II)V");
                break;
            case STACK_IDENTIFIER:
                addMainCode( formatStackInstruction("bipush", operandoDireito->value) );
                addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime addStacks (II)V");
                break;
        }
    }
    else {
        switch (operandoDireito->type) {
            case NUMBER:
                addMainCode( formatNumberInstruction("bipush", operandoDireito->value) );
                addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime sub (II)V");
                break;
            case STACK_IDENTIFIER:
                addMainCode( formatStackInstruction("bipush", operandoDireito->value) );
                addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime subStacks (II)V");
                break;
        }
    }
    free(operador); operador = NULL;
}

void clear(SemanticoTrigger *trigger) {
    addMainCode( formatStackInstruction("bipush", operandoDireito->value) );
    addMainCode("invokestatic Method com/kipple/runtime/KippleRuntime clear (I)V");
}
