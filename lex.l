%{
#include "grammar.tab.h"  // Bison's generated file will have this header
%}

%%
"FACA" { return FACA; }
"SER" { return SER; }
"MOSTRE" { return MOSTRE; }
[0-9]+ { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return VAR; }
[ \t\n\r]+ { /* Ignore whitespace */ }
.       { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }
