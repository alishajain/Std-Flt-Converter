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

{JC}({digits}+;{s}*)+	{ 
			    char* str = strdup( yytext );
			    int i = 0;
			    char *pch;
        		    pch = strtok (str,";\r\n");
        		    while (pch != NULL) {
        			cout << pch << endl;
			//	return jc;
            			pch = strtok (NULL, " ;");
            			i++;
        		    } 
			}
 
{MI}({digits}+;{s}*)+	{ 
                            char* str_mi = strdup( yytext );
                            int i = 0;
                            char *tok;
                            tok = strtok (str_mi,";\r\n");
                            while (tok != NULL) {
				cout << tok << endl;
		//		return mi;
				tok = strtok (NULL, " ;");
				i++;
                            }
                        }
. ;

