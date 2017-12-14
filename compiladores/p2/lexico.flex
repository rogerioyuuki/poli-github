%option noyywrap

%{
#include "main.h"
#define YY_DECL Token yylex()
%}

LETRA [a-zA-Z]
DIGITO [0-9]

COMENTARIO #.*
ESPACADOR [ \t\n\r]

IDENTIFICADOR {LETRA}|@
NUMERO {DIGITO}+
SYMBOL \(|\)|\+|-|\?|>|<

%%

{COMENTARIO} ;
{ESPACADOR} ;

{IDENTIFICADOR} { return CREATE_TOKEN(IDENTIFICADOR, yytext); }
{NUMERO} { return CREATE_TOKEN(NUMERO, yytext); }
{SYMBOL} { return CREATE_TOKEN(SYMBOL, yytext); }

<<EOF>> { return CREATE_TOKEN(EOF_TOKEN, yytext); }

. { return CREATE_TOKEN(UNKNOWN, yytext); }

%%


