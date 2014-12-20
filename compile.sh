bison -d parser.y
flex lexer.l
g++ parser.tab.c lex.yy.c -lfl -o std-flt
./std-flt
