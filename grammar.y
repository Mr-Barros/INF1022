%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(const char *s);
    int yylex(void);

    // Output Rust file pointer
    extern FILE *yyin;
    FILE *outfile;

    // Indentation tracking
    int indent_level = 1;

    void write_indent() {
        for (int i = 0; i < indent_level; i++) {
            fprintf(outfile, "    ");
        }
    }
%}

%union {
    int ival;
    char *sval;
}

%define parse.error verbose
%debug

%token <sval> var
%token <sval> num
%token FACA SER MOSTRE SOME COM REPITA VEZES FIM EOL MOSTRANDO SE ENTAO FOR_IGUAL FOR_MAIOR FOR_MENOR OU E SENAO ABREP FECHAP FIMDOSE

%type <sval> valor
%type <sval> operador_relacional
%type <ival> opt_mostrando

%left OU
%left E
%nonassoc FOR_IGUAL FOR_MAIOR FOR_MENOR

%%

programa: cmd_list;

cmd_list:
    cmd EOL cmd_list 
    | cmd EOL;

cmd:
    atribuicao 
    | impressao 
    | operacao 
    | repeticao 
    | controle;

atribuicao:
    FACA var SER valor 
    { 
        write_indent();
        fprintf(outfile, "let mut %s: u32 = %s;\n", $2, $4); 
    };

impressao:
    MOSTRE valor 
    { 
        write_indent();
        fprintf(outfile, "println!(\"{}\", %s);\n", $2); 
    };

operacao:
    SOME var COM valor opt_mostrando
    {
        write_indent();
        fprintf(outfile, "%s += %s;\n", $2, $4);
        if ($5) {
            write_indent();
            fprintf(outfile, "println!(\"{}\", %s);\n", $2);
        }
    };

opt_mostrando:
    MOSTRANDO 
    { 
        $$ = 1; 
    }
    | /* empty */ 
    { 
        $$ = 0; 
    };

repeticao:
    REPITA valor VEZES 
    { 
        write_indent();
        fprintf(outfile, "for _i in 0..%s {\n", $2); 
        indent_level++;
    } 
    cmd_list
    FIM 
    { 
        indent_level--;
        write_indent();
        fprintf(outfile, "}\n"); 
    };

controle:
    SE 
    { 
        write_indent();
        fprintf(outfile, "if "); 
    } 
    expressao_booleana 
    ENTAO 
    { 
        fprintf(outfile, " {\n"); 
        indent_level++;
    }  
    cmd_list
    opt_senao
    FIMDOSE 
    { 
        indent_level--;
        write_indent();
        fprintf(outfile, "}\n"); 
    };

opt_senao:
    SENAO 
    { 
        indent_level--;
        write_indent();
        fprintf(outfile, "} else {\n"); 
        indent_level++;
    } 
    cmd_list 
    | /* empty */ 
    { 
        /* No else block */
    };

expressao_booleana:
    comparacao;

comparacao:
    valor operador_relacional valor 
    { 
        fprintf(outfile, "%s %s %s ", $1, $2, $3); 
    };

operador_relacional:
    FOR_IGUAL 
    { 
        $$ = "=="; 
    }  
    | FOR_MAIOR 
    { 
        $$ = ">"; 
    }  
    | FOR_MENOR 
    { 
        $$ = "<"; 
    };

valor: 
    var 
    | num;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    // Open input and output files
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

    // Suppress warnings about unused mutable variables in Rust
    fprintf(outfile, "#[allow(unused_mut)]\nfn main() {\n");

    yydebug = 1;

    // Parse input and translate to Rust
    yyparse();

    // End the main function
    fprintf(outfile, "}\n");

    // Close files
    fclose(yyin);
    fclose(outfile);
    return 0;
}
