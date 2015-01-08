cd std-flt
bison -d parser.y
flex lexer.l
g++ write_felt.cc parser.tab.c lex.yy.c -lfl -o std-flt
./std-flt beam.std generate.flt
