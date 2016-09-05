%option noyywrap nodefault yylineno case-insensitive

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "tokens_counter.h"
%}

%%
[ \t]+ {whitespace++; printf("%s\n", yytext);}
[0-9]+ {integers++; printf("%s\n", yytext);}


"(" {left_parenthesis++; printf("%s\n", yytext);}
")" {right_parenthesis++; printf("%s\n", yytext);}

"/*" {left_comment++; printf("%s\n", yytext);}
"*/" {right_comment++; printf("%s\n", yytext);}
"//" {single_comment++; printf("%s\n", yytext);}
"\"" {quotation_mark++, printf("%s\n", yytext);}
"{" {left_parenthesis++; printf("%s\n", yytext);}
"}" {right_parenthesis++; printf("%s\n", yytext);}
"[" {left_sbrackets++; printf("%s\n", yytext);}
"]" {right_sbrackets++; printf("%s\n", yytext);}
";" {semicolons++; printf("%s\n", yytext);}

"==" {double_equal_sign++; printf("%s\n", yytext);}
"<" {less_than_sign++; printf("%s\n", yytext);}
"<=" {less_equal_sign++; printf("%s\n", yytext);}
">" {more_than_sign++; printf("%s\n", yytext);}
">=" {more_equal_sign++; printf("%s\n", yytext);}

"=" {equals_sign++; printf("%s\n", yytext);}
"+" {plus_sign++; printf("%s\n", yytext);}
"++" {plus_plus_sign++; printf("%s\n", yytext);}
"--" {minus_minus_sign++; printf("%s\n", yytext);}
"+=" {plus_equal_sign++; printf("%s\n", yytext);}
"-" {minus_sign++; printf("%s\n", yytext);}
"-=" {minus_equal_sign++; printf("%s\n", yytext);}
"*" {times_sign++; printf("%s\n", yytext);}
"*=" {times_equal_sign++; printf("%s\n", yytext);}
"/" {divide_sign++; printf("%s\n", yytext);}
"/=" {divide_equals_sign++; printf("%s\n", yytext);}
"." {dots++; printf("%s\n", yytext);}

"int" {type_int++; printf("%s\n", yytext);}
"char" {type_char++; printf("%s\n", yytext);}
"float" {type_float++; printf("%s\n", yytext);}
"double" {type_double++; printf("%s\n", yytext);}
"void" {type_void++; printf("%s\n", yytext);}
"boolean" {type_boolean++; printf("%s\n", yytext);}

"if" {if_count++; printf("%s\n", yytext);}
"else" {else_count++; printf("%s\n", yytext);}
"do" {do_count++; printf("%s\n", yytext);}
"for" {for_count++; printf("%s\n", yytext);}
"while" {while_count++; printf("%s\n", yytext);}

"return" {returns++; printf("%s\n", yytext);}

abstract |
continue |
new |
switch |
assert |
default |
goto |
package |
synchronized |
private |
this |
break |
implements |
protected |
byte |
import |
public |
throw |
case |
enum |
instanceof |
transient |
catch |
extends |
short |
try |
final |
interface |
static |
class |
finally |
long |
strictfp |
volatile |
const |
native |
super keywords++; printf("%s\n", yytext);

[a-zA-Z_][a-zA-Z0-9_]* {identifiers++; printf("%s\n", yytext);}

"\n" {new_lines++; printf("%s\n", yytext);}
. {unknown_chars++; printf("Unknown:%s\n", yytext);}


%%
main(int argc, char **argv){

  /* Reads a file if used in the command line */
  if(argc > 1)
  {
    /* Uses FILE as yyin */
    if(!(yyin = fopen(argv[1], "r")))
    {
      perror(argv[1]);
      return(1);
    }
  }

  yylex();
  printf("int: %d, char: %d, float: %d, double: %d\n", type_int, type_char, type_float, type_double);
  printf("Keywords: %d\n", keywords);
  printf("Comments: %d, left_comments: %d, right_comments: %d\n", single_comment, left_comment, right_comment);
  printf("Left_par: %d, Right_par: %d, Left SBrackets: %d, Right SBrackets: %d\n", left_parenthesis, right_parenthesis,
            left_sbrackets, right_sbrackets);
  printf("Semicolons: %d, Quotation marks: %d, Dots: %d,New Lines: %d, Blank spaces: %d\n", semicolons, quotation_mark, dots,
            new_lines, whitespace);
  printf("Equals: %d, Plus: %d, Minus: %d, Times: %d, Divide: %d\n", equals_sign, plus_sign, minus_sign,
            times_sign, divide_sign);
  printf("Plus Plus: %d, Minus Minus: %d\n", plus_plus_sign, minus_minus_sign);
  printf("Plus_E: %d, Minus_E: %d, Times_E: %d, Divide_E: %d\n", plus_equal_sign, minus_equal_sign, times_equal_sign, divide_equals_sign);
  printf("EE: %d, LT: %d, LE: %d, MT: %d, ME: %d\n", double_equal_sign, less_than_sign, less_equal_sign,
            more_than_sign, more_equal_sign);
  printf("If: %d, else: %d, for: %d, while: %d, do: %d\n", if_count, else_count, for_count, while_count, do_count);
  printf("identifiers: %d, integers: %d\n", identifiers, integers);
  printf("Returns: %d, Unknown chars: %d\n\n", returns, unknown_chars);
}
