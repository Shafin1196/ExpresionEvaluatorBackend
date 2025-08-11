%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

DIGIT   [0-9]

%%

[ \t\r]+            { /* skip spaces */ }
\n                  { return '\n'; }

{DIGIT}+            {
                        yylval.val = atoll(yytext);
                        return NUMBER;
                    }

"("                 { return '('; }
")"                 { return ')'; }
"*"                 { return '*'; }
"/"                 { return '/'; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"^"                 { return '^'; }

.                   { /* ignore unknown */ }

%%

int yywrap(void) { return 1; }
