%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"

%}

s       [[:space:]]
digits	[0-9]+
endl	[\r]*[\n]*
jc	(JOINT{s}COORDINATES){endl}
mi	(MEMBER{s}INCIDENCES){endl}

%%

[ \t]	;

{jc}		{ yylval.c = strdup (yytext); return JC; }

{mi}		{ yylval.c = strdup (yytext); return MI; }

{digits}	{ yylval.f = atof (yytext); return DIGIT; }

[;{s}]		{ return EXTRA; }

({digits}+;{s}*)+	{ /*// For joint-coordinates
			    char* str = strdup( yytext );
			    int i = 0;
			    char *value;
        		    value = strtok (str,";\r\n");
        		    while (value != NULL) {
				yylval.c = strdup (value);
				return jc;
                                cout << yylval.c << endl;
            			value = strtok (NULL, " ;");
            			i++;
        		    } 
			    //return jc;*/
			}
 
{mi}({digits}+;{s}*)+	{ /*// For member-incidences
                            char* str_mi = strdup( yytext );
                            int i = 0;
                            char *value;
                            value = strtok (str_mi,";\r\n");
                            while (value != NULL) {
				yylval.c = strdup (value);
				return mi;
				cout << yylval.c << endl;
				value = strtok (NULL, " ;");
				i++;
                            }
			   // return mi;*/
                        }
{endl}			{ return ENDL; }
. ;

