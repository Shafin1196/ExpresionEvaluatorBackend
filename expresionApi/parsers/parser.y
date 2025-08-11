%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>   /* pow() */

int yylex(void);
void yyerror(const char *s);
%}

%union {
    long long val;
}

%token <val> NUMBER
%left '+' '-'
%left '*' '/'
%right '^'           /* right-associative power */
%right UMINUS

%type <val> expr

%%

input:
    /* empty */
  | lines
  ;

lines:
    lines line
  | /* empty */
  ;

line:
    expr '\n'   { printf("%lld\n", $1); }
  | '\n'
  ;

expr:
    NUMBER               { $$ = $1; }
  | expr '+' expr        { $$ = $1 + $3; }
  | expr '-' expr        { $$ = $1 - $3; }
  | expr '*' expr        { $$ = $1 * $3; }
  | expr '/' expr        {
                            if ($3 == 0) {
                                fprintf(stderr, "error: division by zero\n");
                                exit(1);
                            }
                            $$ = $1 / $3;
                         }
  | expr '^' expr        { $$ = (long long) pow((double)$1, (double)$3); }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'         { $$ = $2; }
  ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "syntax error\n");
}

int main(void) {
    return yyparse();
}
