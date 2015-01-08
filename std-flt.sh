cd std-flt
bison -d parser.y
flex lexer.l
g++ write_felt.cc parser.tab.c lex.yy.c -lfl -o convert-std-flt
mv convert-std-flt ..
