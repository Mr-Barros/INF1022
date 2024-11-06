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

%token <sval> var
%token <ival> num
%token FACA SER MOSTRE DOT OI

%%
programa: cmds;
cmds: cmd | cmd cmds;
cmd: atribuicao | impressao | olamundo;
atribuicao: FACA var SER num DOT { printf("Atribuindo: %s = %d\n", $2, $4); };
impressao: MOSTRE num DOT { printf("Mostrando: %d\n", $2); };
olamundo: OI { printf("Ola mundo\n"); };
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
