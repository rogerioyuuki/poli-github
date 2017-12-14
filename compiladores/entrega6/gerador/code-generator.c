#include <stdio.h>
#include "../lib/utarray.h"

#include "../main.h"
#include "../semantico.h"
#include "code-generator.h"
#include "temp-vars.h"
#include "code-repository.h"
#include "expression-evaluator.h"

UT_array *varsBeingDeclared = NULL, *loops, *conditionals = NULL;
char *s, *varBeingAssigned = NULL;
bool waitingForIdentifierToAssign = false;
bool isPrinting = false;

void consumeTransition(CodeGeneratorTransition *transition) {

  const char *submaquinaAtual = transition->submaquinaAtual;
  const char *submaquinaProx = transition->submaquinaProx;
  const char *value = transition->token == NULL ? "---" : transition->token->value;
  int estadoAtual = transition->estadoAtual;
  int estadoProx = transition->estadoProx;

  printf(ANSI_COLOR_CYAN "Consuming transition: %s %d, Token: %s\n" ANSI_COLOR_RESET, submaquinaAtual, estadoAtual, value);

  if (strcmp(submaquinaAtual, "MAIN") == 0) {

    if (estadoAtual == 0) {
      addToDataArea("itoch-A     <");
      addToDataArea("itoch-OUT1  <");
      addToDataArea("itoch-OUT2  <");
      addToDataArea("itoch       <");

      addToDataArea("& /0000");
      addToDataArea("MAIN JP INICIO");
      addToDataArea("ZERO K /0000");
      addToDataArea("UM K /0001");
      addToCodeArea("INICIO LD ZERO");
    } else if (estadoProx == 5) {
      addToCodeArea("FIM HM FIM");
      addToCodeArea("# MAIN");
    }

  }

  if (strcmp(submaquinaAtual, "declaracoes") == 0) {

    if (estadoAtual == 0) {
      printf("Starting a declaration!\n");
      utarray_new(varsBeingDeclared, &ut_str_icd);
    } else if (estadoAtual == 3) {
      printf("Declaration is finished.\n");
      char **p = NULL;
      while ((p=(char**)utarray_next(varsBeingDeclared, p))) {

        /*
         * Allocating memory as a local array
         * https://stackoverflow.com/questions/8716714/bus-error-10-error
         */
         s = stringWithText(*p); strcat(s, " K /0000"); addToDataArea(s);
      }

      utarray_free(varsBeingDeclared); varsBeingDeclared = NULL;

    }

    return; // better being safe, huh?
  }

  if (strcmp(submaquinaAtual, "ATRIBUICAO") == 0) {
    if (estadoAtual == 0) {
      waitingForIdentifierToAssign = true;
    } else if (estadoAtual == 2) {
      startExpression();
    } else if (estadoAtual == 3) {
      char *exp = finishExpression();
      char *s = stringWithText("LD "); strcat(s, exp); strcat(s, " ; Result of Anonymous Expression"); addToCodeArea(s);
      s = stringWithText("MM "); strcat(s, varBeingAssigned); strcat(s, " ; Assignment"); addToCodeArea(s);
      varBeingAssigned = NULL;
    }
  }

  if (strcmp(submaquinaProx, "IDENTIFICADOR") == 0) {
    if (varsBeingDeclared == NULL) {
      utarray_new(varsBeingDeclared, &ut_str_icd);
    }

    {
      bool found = false;
      char ** p = NULL;
      while (p=(char**)utarray_next(varsBeingDeclared,p) ) {
        if (strcmp(value, *p) == 0) {found = true; break;}
      }
      if (!found) {
        utarray_push_back(varsBeingDeclared, &value);
        char *s = stringWithText(value); strcat(s, " K /0000"); addToDataArea(s);
      }
    }

    if (waitingForIdentifierToAssign) {
      varBeingAssigned = (char*)value;
      waitingForIdentifierToAssign = false;
    }

    if (isEvaluatingExpression()) {
      addOperand(transition->token);
      return;
    }

    if (isPrinting) {
      varBeingAssigned = (char*)value;
    }

    return;
  }

  if (strcmp(submaquinaAtual, "CONDICIONAL") == 0) {

    if (estadoAtual == 7) {

      printf("Starting a conditional.\n");

      // init a new stack to store all loops if it's not defined yet.
      if (loops == NULL) {
        utarray_new(conditionals, &ut_str_icd);
      }

      char *condition = startExpression();
      utarray_push_back(conditionals, &condition);
    }

    if (estadoAtual == 8) {
      finishExpression();
      char **condition = (char **)utarray_back(conditionals);

      printf("Condition is stored here %s\n", *condition);
      char *s = stringWithText("LD "); strcat(s, *condition); strcat(s, " ; Condition is here!");

      addToCodeArea(s);
      s = stringWithText("JZ "); strcat(s, *condition); strcat(s, "endif ; Evaluating Conditional");
      addToCodeArea(s);

    }

    if (estadoProx == 13) {
      printf("End if \n");
      char **condition = (char **)utarray_back(conditionals);
      char *s = stringWithText(*condition); strcat(s, "endif LD ZERO"); addToCodeArea(s);

      utarray_pop_back(conditionals);
      if (utarray_len(conditionals) == 0) {
        utarray_free(conditionals); conditionals = NULL;
      }
    }
  }

  if (strcmp(submaquinaAtual, "ITERATIVO") == 0) {
    if (estadoAtual == 3) {
      printf("Starting a loop.\n");

      if (loops == NULL) {
        utarray_new(loops, &ut_str_icd);
      }

      char *condition = startExpression();
      utarray_push_back(loops, &condition);

      char *s = stringWithText(condition); strcat(s, "startLoop LD ZERO ; Beginning of a loop"); addToCodeArea(s);
    }

    if (estadoAtual == 5) {
      finishExpression();
      char **condition = (char **)utarray_back(loops);
      char *s = stringWithText("LD "); strcat(s, *condition); strcat(s, " ; Verifying loop condition"); addToCodeArea(s);
      s = stringWithText("JZ "); strcat(s, *condition); strcat(s, "endLoop"); addToCodeArea(s);
    }

    if (estadoProx == 7) {
      printf("Finishing loop.\n");
      char **condition = (char **)utarray_back(loops);
      char *s = stringWithText("JP "); strcat(s, *condition); strcat(s, "startLoop ; Loop"); addToCodeArea(s);
      s = stringWithText(*condition); strcat(s, "endLoop LD ZERO"); addToCodeArea(s);

      utarray_pop_back(loops);
      if (utarray_len(loops) == 0) {
        utarray_free(loops); loops = NULL;
      }
    }
  }

  if (strcmp(submaquinaProx, "NUMERO") == 0) {
    if (isEvaluatingExpression()) {
      addOperand(transition->token);
      return;
    }
  }

  if (strcmp(submaquinaAtual, "OPERADOR_ARITM") == 0 && estadoAtual == 0) {
    if (isEvaluatingExpression()) {
      addOperator(transition->token);
      return;
    }
  }

  if (strcmp(submaquinaAtual, "OPERADOR_COMP") == 0 && estadoAtual == 0) {
    if (isEvaluatingExpression()) {
      addOperator(transition->token);
      return;
    }
  }

  if (strcmp(submaquinaAtual, "PRINT") == 0) {
    if (estadoAtual == 0) {
      isPrinting = true;
    }

    if (estadoAtual == 8) {
      isPrinting = false;
      char *s = stringWithText("LD "); strcat(s, varBeingAssigned); addToCodeArea(s);
      addToCodeArea("MM itoch-A");
      addToCodeArea("SC itoch");
      addToCodeArea("LD itoch-OUT1");
      addToCodeArea("PD /0");
      addToCodeArea("LD itoch-OUT2");
      addToCodeArea("PD /0");
    }
  }

}

/**
 * Inits this module, initializing arrays and setting initial vars.
 */
void initCodeGenerator() {
  initCode();
}
