set -e
echo "Running Bison..."
bison -d grammar.y -Wconflicts-sr -Wconflicts-rr -Wcounterexamples
echo "Running lex..."
lex lex.l
echo "Compiling grammar and lex..."
gcc grammar.tab.c lex.yy.c -o grammar -lfl
echo "Running grammar to generate Rust file..."
./grammar
echo "Compiling the generated Rust code..."
rustc output.rs
echo "Running the Rust Code"
./output