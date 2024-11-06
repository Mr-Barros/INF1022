%{
#include "grammar.tab.h"  // Bison's generated file will have this header
%}

%%

[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[+\-*/\n] { return yytext[0]; }
[ \t]   ; /* ignore whitespace */
.       { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }
