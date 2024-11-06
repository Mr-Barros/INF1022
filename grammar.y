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
%token FACA SER MOSTRE SOME MULTIPLIQUE REPITA FIM SE ENTAO SENAO COM POR VEZES
%left '+' '-'
%left '*' '/'

%%
program: cmds;
cmds: cmd | cmd cmds;

cmd: atribuicao | impressao | operacao | repeticao | controle;

atribuicao: FACA var SER num;
impressao: MOSTRE var | MOSTRE operacao;
operacao: SOME var COM var | SOME var COM num | SOME num COM num | MULTIPLIQUE var POR var;
repeticao: REPITA num VEZES: cmds FIM;
controle: SE condicao ENTAO cmds | SE condicao ENTAO cmds SENAO cmds;
condicao: num;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
