%{
#include "1.tab.h"
#include <string.h>
%}

ID      [a-zA-Z_][a-zA-Z0-9_]*
NUM     [0-9]+

%%

{ID}    { strcpy(yylval.str, yytext); return ID; }
{NUM}   { strcpy(yylval.str, yytext); return NUM; }
"="     { return '='; }
"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
"("     { return '('; }
")"     { return ')'; }
[ \t]    ;
\n       { return '\n'; }
.        { return yytext[0]; }

%%

int yywrap() { return 1; }