howl.util.lpeg_lexer ->
  c = capture

  keyword = c 'keyword', word {
    'rec', 'with', 'let', 'in', 'inherit',
    'assert', 'if', 'else', 'then', '...'
  }

  builtins = c 'function', word {
    'import', 'abort', 'baseNameOf', 'dirOf', 'isNull', 'builtins',
    'map', 'removeAttrs', 'throw', 'toString', 'derivation'
  }

  comment_span = (start_pat, end_pat) ->
    start_pat * ((V'nested_comment' + P 1) - end_pat)^0 * (end_pat + P(-1))

  comment = c 'comment', any {
    '#' * scan_until(eol),
    P { 'nested_comment', nested_comment: comment_span('/*','*/') }
  }

  string = c 'string', span('"', '"', '\\')

  -- operator = c 'operator', S'+-*!/%^#~=<>;,.(){}[]?'
  operator = c 'operator', word {
    '++', '+', '?', '.', '!', '//', '==',
    '!=', '&&', '||', '->', '='
  }

  -- numbers
  hexadecimal_number = P'0x' * R('AF','af','09')^1
  float = digit^0 * P'.' * digit^1

  number = c 'number', any {
    hexadecimal_number,
    (float + digit^1) * (S'eE' * P('-')^0 * digit^1)^0
  }

  -- identifiers
  ident = (alpha + '_')^1 * (alpha + digit + '_')^0
  identifier = c 'identifier', ident

  path = any {
    '<' * (S('.+-') + alpha)^1 * ('/' * (S('.+-') + alpha)^1)^0 * '>'
    (S('.+-') + alpha)^0 * ('/' * (S('.+-') + alpha)^1)^1
  }

  special = c 'special', any {
    'true',
    'false',
    'null',
    ident * ":",
    ident * "@",
    path
  }

  any {
    number,
    string,
    comment,
    special,
    operator,
    keyword,
    identifier,
    builtins
  }
