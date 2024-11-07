%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

// Output Rust file pointer
extern FILE *yyin;
FILE *outfile;
%}

%union {
    int ival;
    char *sval;
}

%token <sval> var
%token <sval> num
%token FACA SER MOSTRE SOME COM REPITA VEZES FIM EOL

%type <sval> valor

%%
programa: cmds;
cmds: cmd | cmd cmds;
cmd: atribuicao | impressao | operacao | repeticao;

atribuicao: 
    FACA var SER valor EOL { fprintf(outfile, "let mut %s: u32 = %s;\n", $2, $4); };
impressao:
    MOSTRE valor EOL { fprintf(outfile, "println!(\"{}\", %s);\n", $2); };
operacao:
    SOME valor COM valor EOL { fprintf(outfile, "%s += %s;\n", $2, $4); };
repeticao:
    REPITA valor VEZES { fprintf(outfile, "for _i in 0..%s {\n", $2); } 
    cmds
    FIM { fprintf(outfile, "}\n"); };

valor: var | num
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    // open input and output files
    yyin = fopen("input.mag", "rt");
    if (!yyin) {
        perror("Error opening input file\n");
        exit(1);
    }
    outfile = fopen("output.rs", "wt");
    if (!outfile) {
        perror("Error opening output file\n");
        exit(1);
    }

    // #[allow(unused_mut)] suppresses warnings from the rust compiler about let mut variables that were not mutated
    // fn main() defines the main function
    fprintf(outfile, "#[allow(unused_mut)]\nfn main() {\n");

    // parses the input file and translates to rust, writing to the output file according to the grammar above
    yyparse();

    // end the main function definition
    fprintf(outfile, "}");

    // close input and output files
    fclose(yyin);
    fclose(outfile);
    return 0;
}
