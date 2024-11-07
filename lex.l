%{
#include "grammar.tab.h"  // Bison's generated file will have this header
%}

%%
"FACA"|"faca" { return FACA; }
"SER"|"ser" { return SER; }
"MOSTRE"|"mostre" { return MOSTRE; }
"SOME"|"some" { return SOME; }
"COM"|"com" { return COM; }
"REPITA"|"repita" { return REPITA; }
"VEZES:"|"vezes:" { return VEZES; }
"FIM"|"fim" { return FIM; }
"." { return EOL; }
[ \t\n]+   { /* ignore whitespace */ }
[0-9]+ { yylval.sval = strdup(yytext); return num; }
[a-zA-Z_]+ { yylval.sval = strdup(yytext); return var; }
.       { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }
