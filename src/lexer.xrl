Definitions.

D = [0-9]
B = [0|1]
O = [0-7]
H = [0-9A-Ea-e]
LC = [a-z]
UC = [A-Z]
L = [A-Za-z]
A = [A-Za-z0-9@_]
ALIASES = [A-Z-a-z0-9_]


DELIMITERS = \[|\]|\{|\}|(<<)|(>>)|(\%\{)|\(|\)
OPERATORS = =|&|@|\-|\*|\\|!|\^|~~~|\+|\++|--|\.\.|<>|\+++|---|\^\^\^|<|>|<=|>=|==|!=|=~|===|!==|&&|&&&|\|\||\|\|\||=>|\||::|\|>|<<<|>>>|<<~|,|\.

UNICODE = [!-𯨟]
RESERVED_ATOM = nil|true|false
RESERVED_OPERATOR = when|and|or|not|in
RESERVED_FN = fn
RESERVED_BLOCK = do|end|catch|rescue|after|else
RESERVED_GENERAL = require|defmodule|def|alias|import


Rules.

{RESERVED_ATOM} : {token, {reserved_atom, TokenLine, TokenChars}}.
{RESERVED_OPERATOR} : {token, {reserved_operator, TokenLine, TokenChars}}.
{RESERVED_FN} : {token, {reserved_fn, TokenLine, TokenChars}}.
{RESERVED_BLOCK} : {token, {reserved_block, TokenLine, TokenChars}}.
{RESERVED_GENERAL} : {token, {reserved_general, TokenLine, TokenChars}}.

{D}+(\_{D}+)*\.{D}+(\_{D})*((e|E)10)? : {token, {float, TokenLine, TokenChars}}.
{D}+(\_{D}+)* : {token, {integer, TokenLine, TokenChars}}.
0x{H}+(\_{H}+)* :  {token, {hexadecimal, TokenLine, TokenChars}}.
0o{O}+(\_{O}+)* :  {token, {octal, TokenLine, TokenChars}}.
0b{B}+(\_{B}+)* :  {token, {binary, TokenLine, TokenChars}}.
\?{UNICODE} : {token, {unicode_point, TokenLine, TokenChars}}.

:(({L}{A}*(\!|\?)?)|{RESERVED_OPERATOR}|{OPERATORS}) : {token, {atom, TokenLine, TokenChars}}.
:'([^'])*' : {token, {single_quoted_atom, TokenLine, TokenChars}}.
:"([^"])*" : {token, {double_quoted_atom, TokenLine, TokenChars}}.
{L}{A}*(\!|\?)?: : {token, {keyword_atom, TokenLine, TokenChars}}.

"([^"]|(\\"))*" : {token, {string, TokenLine, TokenChars}}.
"""([^"]|(\\")|\n)*""" : {token, {multiline_string, TokenLine, TokenChars}}.

'([^']|(\\'))*' : {token, {charlist, TokenLine, TokenChars}}.
'''([^'|(\\')|\n])*''' : {token, {multiline_charlist, TokenLine, TokenChars}}.

{DELIMITERS} : {token, {delimiter, TokenLine, TokenChars}}.

{LC}{A}*(\!|\?)? : {token, {variable, TokenLine, TokenChars}}.
_{A}*(\!|\?)? : {token, {hidden_variable, TokenLine, TokenChars}}.

{OPERATORS} : {token, {operator, TokenLine, TokenChars}}.

{UC}{ALIASES}* : {token, {alias, TokenLine, TokenChars}}.

#({UNICODE}|\s)* : {token, {comment, TokenLine, TokenChars}}.

[\s]+          : {token, {skip, TokenLine, TokenChars}}.
(\r\n)|\n|\r         : {token, {newline, TokenLine, TokenChars}}.


Erlang code.