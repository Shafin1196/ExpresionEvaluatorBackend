%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);

double result;
%}

%union {
    double dval;
}

%token <dval> NUMBER

%left '+' '-'
%left '*' '/'
%right POWER
%right UMINUS

%type <dval> expr

%%

input:
    /* empty */
  | input line
  ;

line:
    '\n'
  | expr '\n'   {
                    result = $1;
                    printf("%lf\n", result);
                }
  ;

expr:
    NUMBER                      { $$ = $1; }
  | expr '+' expr               { $$ = $1 + $3; }
  | expr '-' expr               { $$ = $1 - $3; }
  | expr '*' expr               { $$ = $1 * $3; }
  | expr '/' expr               {
                                     if ($3 == 0) {
                                     fprintf(stderr, "error: division by zero\n");
                                     exit(1);
                                }
                                $$ = $1 / $3;
                                }
  | expr POWER expr             { $$ = pow($1, $3); }
  | '-' expr %prec UMINUS       { $$ = -$2; }
  | '(' expr ')'                { $$ = $2; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
