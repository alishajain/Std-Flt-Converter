%{
#include <iostream>
using namespace std;

#define YY_DECL extern "C" int yylex()

//#include "parser.tab.h"
%}

s       [[:space:]]
digits	[0-9]+{s}*
endl	[\n]
%%

(JOINT{s}COORDINATES){endl}{digits}+	{ cout << "alisha	" << yytext << endl; }
. ;

%%

main() {
	
	// open a file handle to a particular file:
	FILE *myfile = fopen("beam.std", "r");
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// lex through the input:
	yylex();
}
