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

[a-zA-Z]+[\n]	{ cout << yytext; }
(JOINT{s}COORDINATES){s}		{ cout << yytext << endl; }
(JOINT{s}COORDINATES){endl}{digits}+	{ cout << "alisha	" << yytext << endl; }
{digits}+	{ cout << yytext; }
. ;

%%

main() {
	
	// open a file handle to a particular file:
	FILE *myfile = fopen("aj.txt", "r");
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// lex through the input:
	yylex();
}
