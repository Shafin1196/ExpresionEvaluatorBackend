%{
#include "parser.tab.h"
#include <stdlib.h>
%}

digit   [0-9]
number  {digit}+(\.{digit}+)?([eE][-+]?{digit}+)?

%%
[ \t]+                  ;   // ignore whitespace
{number}                {
                            yylval.dval = atof(yytext);
                            return NUMBER;
                        }
"^"                     return POWER;
"+"                     return '+';
"-"                     return '-';
"*"                     return '*';
"/"                     return '/';
"("                     return '(';
")"                     return ')';
\n                      return '\n';
.                       return yytext[0];

%%
int yywrap(void) { return 1; }