set -e
echo "Running Bison..."
bison -d grammar.y -Wconflicts-sr -Wconflicts-rr -Wcounterexamples
echo "Running lex..."
lex lex.l
echo "Compiling grammar and lex..."
gcc grammar.tab.c lex.yy.c -o grammar -ll
echo "Running grammar to generate Rust file..."
./grammar output input.mag
echo "Running the Rust Code"
./output