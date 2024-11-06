%{
#include "grammar.tab.h"  // Bison's generated file will have this header
%}

%%
"FACA" { return FACA; }
"MOSTRE" { return MOSTRE; }
"SOME" { return SOME; }
"MULTIPLIQUE" { return MULTIPLIQUE; }
"REPITA" { return REPITA; }
"VEZES" { return VEZES; }
"ENTAO" { return ENTAO; }
"SENAO" { return SENAO; }
[0-9]+ { yylval = atoi(yytext); return num; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return var; }
.       { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }
