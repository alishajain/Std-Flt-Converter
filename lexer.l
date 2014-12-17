%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
//include "parser.tab.h"

char* split_token( char* str)
{
  int i = 0;
  char *pch;
  pch = strtok (str,";\r\n");
  while (pch != NULL)
  {
    cout << pch << endl;
    pch = strtok (NULL, " ;");
    i++;
  }
return pch; 
}

%}

s       [[:space:]]
digits	[0-9]+{s}*
endl	[\r]*[\n]*
JC	(JOINT{s}COORDINATES){endl}
MI	(MEMBER{s}INCIDENCES){endl}

%%

[ \n\t]	;

{JC}({digits}+;{s}*)+	{ char* str = strdup( yytext ); char* p = split_token(str); }

{MI}({digits}+;{s}*)+	{ char* str = strdup( yytext ); char* p = split_token(str); }

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
