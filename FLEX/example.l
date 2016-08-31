/* Declaração de variáveis que serão usadas */

%option noyywrap nodefault yylineno case-insensitive

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "tokens_counter.h"
%}

%%
"int" {type_int++;}
"char" {type_char++;}
"float" {type_float++;}
"double" {type_double++;}
"void" {type_void++;}
"boolean" {type_boolean++;}

"if" {}
"else" {}
"do" {}
"for" {}
"while" {}

"return" {}

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
super keywords++;

[0-9]+ {numbers++;}
([a-zA-Z_][a-zA-Z0-9]+) {variables++;}

"(" {left_parenthesis++;}
")" {right_parenthesis++;}

"/*" {left_comment++;}
"*/" {right_comment++;}
"//" {single_comment++;}
"{" {left_parenthesis++;}
"}" {right_parenthesis++;}
";" {semicolons++;}

"==" {double_equal_sign++;}
"<" {less_than_sign++;}
"<=" {less_equal_sign++;}
">" {more_than_sign++;}
">=" {more_equal_sign++;}

"=" {equals_sign++;}
"+" {plus_sign++;}
"+=" {plus_equal_sign++;}
"-" {minus_sign++;}
"-=" {minus_equal_sign++;}
"*" {times_sign++;}
"*=" {times_equal_sign++;}
"/" {divide_sign++;}
"/=" {divide_equals_sign++;}

"\n" {new_lines++;}
[ \t]* {whitespace++;}
. {unknown_chars++;}


%%
main(int argc, char **argv){
  yylex();
  printf("int: %d, char: %d, float: %d, double: %d\n", type_int, type_char, type_float, type_double);
  printf("Keywords: %d\n", keywords);
  printf("Comments: %d, left_comments: %d, right_comments: %d\n", single_comment, left_comment, right_comment);
  printf("Left_par: %d, Right_par: %d\n", left_parenthesis, right_parenthesis);
  printf("Semicolons: %d, New Lines: %d, Blank spaces: %d\n", semicolons, new_lines, whitespace);
  printf("Equals: %d, Plus: %d, Minus: %d, Times: %d, Divide: %d\n", equals_sign, plus_sign, minus_sign,
                                                                                  times_sign, divide_sign);
  printf("Plus_E: %d, Minus_E: %d, Times_E: %d, Divide_E: %d\n", plus_equal_sign, minus_equal_sign, times_equal_sign, divide_equals_sign);
  printf("EE: %d, LT: %d, LE: %d, MT: %d, ME: %d\n", double_equal_sign, less_than_sign, less_equal_sign,
                                                                      more_than_sign, more_equal_sign);
  printf("Variables: %d, numbers: %d, \n", variables, numbers);
  printf("Unknown chars: %d\n\n", unknown_chars);
}
