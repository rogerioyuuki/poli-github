%option noyywrap

%{
#include "main.h"
#define YY_DECL Token yylex()
%}

LETRA [a-zA-Z]
NUMERO [0-9]
LETRA_NUMERO {LETRA}|{NUMERO}

COMENTARIO \/\/.*|\/\*(.|[\n\r])*\*\/
ESPACADOR [ \t\n\r]

IDENTIFIER {LETRA}{LETRA_NUMERO}*
INTEGER {NUMERO}+
DECIMAL {NUMERO}+\.{NUMERO}*|\.{NUMERO}+
STRING ".*"|'.*'
KEYWORD if|else|case|default|break|for|while|continue|function|return|switch|int|float|string|void|struct|typedef
SYMBOL =\{1,2\}|!=?|>=?|<=?|\+|-|\*|\/|&|,|;|\||\{|\}|\(|\)

%%

{COMENTARIO} ;
{ESPACADOR} ;

{KEYWORD} { return CREATE_TOKEN(KEYWORD, yytext); }
{IDENTIFIER} { return CREATE_TOKEN(IDENTIFIER, yytext); }
{INTEGER} { return CREATE_TOKEN(INTEGER, yytext); }
{DECIMAL} { return CREATE_TOKEN(DECIMAL, yytext); }
{STRING} { return CREATE_TOKEN(STRING, yytext); }
{SYMBOL} { return CREATE_TOKEN(SYMBOL, yytext); }

<<EOF>> { return CREATE_TOKEN(EOF_TOKEN, yytext); }

%%


