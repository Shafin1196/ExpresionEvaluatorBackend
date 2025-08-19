%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;
void gen(char* res, char* op1, char* op, char* op2);
%}

%union {
    char str[100];
}

%token <str> ID
%token <str> NUM
%left '+' '-'
%left '*' '/'

%type <str> expr term factor stmt

%%
input: stmt '\n' { /* do nothing */ }
     | input stmt '\n' { /* do nothing */ }
     ;


stmt: ID '=' expr { printf("%s = %s\n", $1, $3); }
    ;

expr: expr '+' term {
        char temp[10];
        sprintf(temp, "t%d", tempCount++);
        gen(temp, $1, "+", $3);
        strcpy($$, temp);
    }
    | expr '-' term {
        char temp[10];
        sprintf(temp, "t%d", tempCount++);
        gen(temp, $1, "-", $3);
        strcpy($$, temp);
    }
    | term { strcpy($$, $1); }
    ;

term: term '*' factor {
        char temp[10];
        sprintf(temp, "t%d", tempCount++);
        gen(temp, $1, "*", $3);
        strcpy($$, temp);
    }
    | term '/' factor {
        char temp[10];
        sprintf(temp, "t%d", tempCount++);
        gen(temp, $1, "/", $3);
        strcpy($$, temp);
    }
    | factor { strcpy($$, $1); }
    ;

factor: ID   { strcpy($$, $1); }
      | NUM  { strcpy($$, $1); }
      | '(' expr ')' { strcpy($$, $2); }
      | '-' factor {
            char temp[10];
            sprintf(temp, "t%d", tempCount++);
            gen(temp, $2, "-", NULL); // t = -s
            strcpy($$, temp);
        }
      ;

%%

void gen(char* res, char* op1, char* op, char* op2) {
    if (op2 == NULL && strcmp(op, "-") == 0) {
        printf("%s = -%s\n", res, op1);
    } else {
        printf("%s = %s %s %s\n", res, op1, op, op2);
    }
}

int main() {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}