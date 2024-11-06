%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

// Output Rust file pointer
FILE *outfile;
%}

%union {
    int ival;
    char *sval;
}

%token <sval> VAR
%token <ival> NUMBER
%token FACA SER MOSTRE

%%
program: cmds;
cmds: cmd | cmd cmds;

cmd: atribuicao | impressao;

atribuicao: FACA VAR SER NUMBER;
impressao: MOSTRE NUMBER { printf("Mostrando: %d\n", $1); };

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
