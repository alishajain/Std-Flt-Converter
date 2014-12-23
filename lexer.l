%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"

%}

s       [[:space:]]
digits	[0-9]+{s}*
endl	[\r]*[\n]*
JC	(JOINT{s}COORDINATES){endl}
MI	(MEMBER{s}INCIDENCES){endl}

%%

[ \n\t]	;

{JC}({digits}+;{s}*)+	{ // For joint-coordinates 
			    char* str = strdup( yytext );
			    int i = 0;
			    char *tok;
        		    value = strtok (str,";\r\n");
        		    while (value != NULL) {
				yylval.c = value;
            			value = strtok (NULL, " ;");
            			i++;
        		    } 
			    return jc;
			}
 
{MI}({digits}+;{s}*)+	{ // For member-incidences
			    cout << yytext << endl;
                            char* str_mi = strdup( yytext );
                            int i = 0;
                            char *value;
                            value = strtok (str_mi,";\r\n");
                            while (value != NULL) {
                                yylval.c = strdup(value);
		//		return mi;
				tok = strtok (NULL, " ;");
				i++;
                            }
			    return mi;
                        }
. ;

