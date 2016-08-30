/* Declaração de variáveis que serão usadas */
%{
  int numbers = 0;

  int single_comment = 0;
  int left_comment = 0;
  int right_comment = 0;
  int left_parenthesis = 0;
  int right_parenthesis = 0;
  int semicolons = 0;
  int unknown_chars = 0;
  int new_lines = 0;
  int blank_spaces = 0;

  int type_int = 0;
  int type_char = 0;
  int type_double = 0;
  int type_float = 0;
  int type_boolean = 0;
  int type_void = 0;


  int words = 0;
%}

%%
"int" {type_int++;}
"char" {type_char++;}
"float" {type_float++;}
"double" {type_double++;}
"void" {type_void++;}
"boolean" {type_boolean++;}

[0-9]+ {numbers++;}
[A-Za-z]+ {words++;}


"/*" {left_comment++;}
"*/" {right_comment++;}
"//" {single_comment++;}
"{" {left_parenthesis++;}
"}" {right_parenthesis++;}
";" {semicolons++;}
" "+ {blank_spaces++;}
. {unknown_chars++;}

"\n" {new_lines++;}

%%
main(int argc, char **argv){
  yylex();
  printf("int: %d, char: %d, float: %d, double: %d\n", type_int, type_char, type_float, type_double);
  printf("Comments: %d, left_comments: %d, right_comments: %d\n", single_comment, left_comment, right_comment);
  printf("Left_par: %d, Right_par: %d\n", left_parenthesis, right_parenthesis);
  printf("Semicolons: %d, New Lines: %d, Blank spaces: %d\n", semicolons, new_lines, blank_spaces);
  printf("Words: %d, numbers: %d, \n", words, numbers);
  printf("Unknown chars: %d\n\n", unknown_chars);
}
