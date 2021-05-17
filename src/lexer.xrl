Definitions.

D = [0-9]
B = [0|1]
O = [0-7]
H = [0-9A-Ea-e]
L = [A-Za-z]
A = [A-Za-z0-9@_]
UNICODE = [!-𯨟]
RESERVED_ATOM = nil|true|false
RESERVED_OPERATOR = when|and|or|not|in
RESERVED_FN = fn
RESERVED_BLOCK = do|end|catch|rescue|after|else


Rules.

{RESERVED_ATOM} : {token, {reservedAtom, TokenLine, TokenChars}}.
{RESERVED_OPERATOR} : {token, {reservedOperator, TokenLine, TokenChars}}.
{RESERVED_FN} : {token, {reservedFn, TokenLine, TokenChars}}.
{RESERVED_BLOCK} : {token, {reservedBlock, TokenLine, TokenChars}}.

{D}+(\_{D}+)*\.{D}+(\_{D})*((e|E)10)? : {token, {float, TokenLine, TokenChars}}.
{D}+(\_{D}+)* : {token, {integer, TokenLine, TokenChars}}.

:{L}{A}*(\!|\?)? : {token, {atom, TokenLine, TokenChars}}.
:'({UNICODE}|\s)*' : {token, {singleQuotedAtom, TokenLine, TokenChars}}.
:"({UNICODE}|\s)*" : {token, {doubleQuotedAtom, TokenLine, TokenChars}}.

"({UNICODE}|\s)*" : {token, {string, TokenLine, TokenChars}}.
"""({UNICODE}|\s|\n)*""" : {token, {multilineString, TokenLine, TokenChars}}.


[\s]+          : {token, {skip, TokenLine, TokenChars}}.
(\r\n)|\n|\r         : {token, {newline, TokenLine, TokenChars}}.
% {D}+        : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
[\+\-\*\/]  : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[\(\)]      : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.


Erlang code.