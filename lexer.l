%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"
int line_num = 1;

%}

space		[[:space:]]
digits		[0-9]+
integer		{digits}
float		{integer}"."{digits}*
endl		[\r]*[\n]*
jc		(JOINT{space}COORDINATES{endl})
mi		(MEMBER{space}INCIDENCES{endl})
semicolon	[;]
finish		(FINISH)

month           Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec
date            ({digits}-{month}-{digits})
width           (WIDTH{space}{digits})

%%

{jc}		{ yylval.c = strdup (yytext); return JC; }

{mi}		{ yylval.c = strdup (yytext); return MI; }

{integer}	{  yylval.f = atof (yytext); return DIGIT; }

{width}

{date}

{semicolon}	{ return SEMICOLON; }

{finish}	{ return FINISH; }

.			;

