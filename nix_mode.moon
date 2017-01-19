
class NixMode
  new: =>
    @lexer = bundle_load('nix_lexer')
    @completers = { 'in_buffer' }

  comment_syntax: '#'

  auto_pairs: {
    '(': ')'
    '[': ']'
    '{': '}'
    '"': '"'
    "'": "'"
  }

  indentation: {
    more_after: {
      r'[({=]\\s*(#.*|)$'
      'let'
    }

    less_for: {
      '^%s*}'
      r'^\\s*\\}\\b'
    }
  }

  code_blocks:
    multiline: {
    }
