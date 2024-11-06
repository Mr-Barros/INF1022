%{
#include "grammar.tab.h"  // Bison's generated file will have this header
%}

%%
"FACA" { return FACA; }
"SER" { return SER; }
"MOSTRE" { return MOSTRE; }
"OI" { return OI; }
"." { return DOT; }
[0-9]+ { yylval.ival = atoi(yytext); return num; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return var; }
.       { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }
