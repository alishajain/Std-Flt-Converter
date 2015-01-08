cd flt-std
bison -d parser.y
flex lexer.l
g++ write.cc parser.tab.c lex.yy.c -lfl -o flt-std 
./flt-std beam.flt generate.std               

