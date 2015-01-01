%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"
int line_num = 1;

%}

space		[[:space:]]
digit		[0-9]+
integer		{digit}
float		{integer}"."{digit}*
endl		[\r]*[\n]*
jc		(JOINT{space}COORDINATES{endl})
mi		(MEMBER{space}INCIDENCES{endl})
semicolon	[;]
finish		(FINISH)

month           Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec
date            ({digit}-{month}-{digit})
width           (WIDTH{space}{digit})

%%

{jc}			{ yylval.c = strdup (yytext); return JC; }

{mi}			{ yylval.c = strdup (yytext); return MI; }

{integer}|{float}	{  yylval.f = atof (yytext); return DIGIT; }

{width}

{date}

{semicolon}		{ return SEMICOLON; }

{finish}		{ return FINISH; }

.			;

