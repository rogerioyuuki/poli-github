%option noyywrap

%{
#include "main.h"
#define YY_DECL Token yylex()
%}

LETRA [a-zA-Z]
DIGITO [0-9]

COMENTARIO #.*
ESPACADOR [ \t\n\r]

STACK_IDENTIFIER {LETRA}|@
NUMBER {DIGITO}+
SYMBOL \(|\)|\+|-|\?|>|<

%%

{COMENTARIO} ;
{ESPACADOR} ;

{STACK_IDENTIFIER} { return CREATE_TOKEN(STACK_IDENTIFIER, yytext); }
{NUMBER} { return CREATE_TOKEN(NUMBER, yytext); }
{SYMBOL} { return CREATE_TOKEN(SYMBOL, yytext); }

<<EOF>> { return CREATE_TOKEN(EOF_TOKEN, yytext); }

. { return CREATE_TOKEN(UNKNOWN, yytext); }

%%
