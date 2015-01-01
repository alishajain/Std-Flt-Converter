%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"
int line_num = 1;

%}

s       [[:space:]]
digit	[0-9]
float	{digit}+"."{digit}*
endl	[\r]*[\n]*
jc	(JOINT{s}COORDINATES){endl}
mi	(MEMBER{s}INCIDENCES){endl}

%%

{jc}	{ yylval.c = strdup (yytext); return JC; }

{mi}	{ yylval.c = strdup (yytext); return MI; }

{float}	{ yylval.f = atof (yytext); cout << yytext; return DIGIT; }

[;{s}]	{ return EXTRA;/* }

({digits}+;{s}*)+	{ *//*// For joint-coordinates
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
		/*	}
 
{mi}({digits}+;{s}*)+	{ *//*// For member-incidences
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

{endl}			{ ++line_num; return ENDL; }

.			;

