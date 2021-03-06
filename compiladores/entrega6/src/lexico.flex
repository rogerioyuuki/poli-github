%option noyywrap

%{
#include "main.h"
#define YY_DECL Token yylex()
%}

LETRA [a-zA-Z]
DIGITO [0-9]
LETRA_DIGITO {LETRA}|{DIGITO}

COMENTARIO \/\/.*|\/\*(.|[\n\r])*\*\/
ESPACADOR [ \t\n\r]

IDENTIFICADOR {LETRA}{LETRA_DIGITO}*
NUMERO {DIGITO}+|{DIGITO}+\.{DIGITO}*|\.{DIGITO}+
STRING ".*"|'.*'
KEYWORD BIRL|FRANGO|MONSTRINHO|MONSTRO|MONSTRAO|BICEPS|TRAPEZIO|DESCENDENTE|OH|O|HOME|AI|PO|HORA|DO|SHOW|FIBRA|AGUA|NEGATIVA|AJUDA|MALUCO|TA|DOENTE|ELE|QUE|A|GENTE|QUER|NAO|VAI|DAR|BAMBAM|MAIS|QUERO|BORA|CUMPADE|SAI|FDP|VAMO|CE|VER|ESSA|PORRA
SYMBOL =|==|!=?|>=?|<=?|\+|-|\*|\/|&|&&|,|;|\||\|\||\{|\}|\(|\)|%

%%

{COMENTARIO} ;
{ESPACADOR} ;

{KEYWORD} { return CREATE_TOKEN(KEYWORD, yytext); }
{IDENTIFICADOR} { return CREATE_TOKEN(IDENTIFICADOR, yytext); }
{NUMERO} { return CREATE_TOKEN(NUMERO, yytext); }
{STRING} { return CREATE_TOKEN(STRING, yytext); }
{SYMBOL} { return CREATE_TOKEN(SYMBOL, yytext); }

<<EOF>> { return CREATE_TOKEN(EOF_TOKEN, yytext); }

. { return CREATE_TOKEN(UNKNOWN, yytext); }

%%


