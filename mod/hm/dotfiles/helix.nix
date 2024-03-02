{ ... }: {
  home.file.".config/helix/languages.toml".text = # toml
    ''
      [language-server.rust-analyzer.config.check]
      command = "clippy"

      [[language]]
      name = "nix"
      formatter = { command = "nixfmt" }
      auto-format = true
      language-servers = [ "nil" ]

      [[language]]
      name = "markdown"
      language-servers = [ "marksman" ]

      [[language]]
      name = "toml"
      auto-format = true
    '';

  home.file.".config/helix/config.toml".text = # toml
    ''
      theme = "horizon-dark"

      [keys.normal]
      up = "no_op"
      down = "no_op"
      left = "no_op"
      right = "no_op"
      pageup = "no_op"
      pagedown = "no_op"
      home = "no_op"
      end = "no_op"
      C-s = ":w"
      C-p = [ "insert_newline", "paste_before" ]
      C-n = [ "select_mode", "move_char_right", "move_prev_word_start", "move_next_word_start", "search_selection" ]
      C-q = ":buffer-close"

      [keys.insert]
      up = "no_op"
      down = "no_op"
      left = "no_op"
      right = "no_op"
      pageup = "no_op"
      pagedown = "no_op"
      home = "no_op"
      end = "no_op"
      C-q = "normal_mode"
      C-s = ":w"

      [keys.select]
      C-n = "extend_search_next"

      [editor]
      # mouse = false
      bufferline = "always"
      line-number = "relative"
      true-color = true

      [editor.cursor-shape]
      insert = "bar"
      normal = "bar"

      [editor.file-picker]
      hidden = false





      [editor.indent-guides]
      render = true
      character = "▏"
    '';

  home.file.".config/helix/runtime/queries/rust/injections.csm".text = # scheme
    ''
      ([(line_comment) (block_comment)] @injection.content
       (#set! injection.language "comment"))

      ; mark arbitary languages with a comment
      ((([(line_comment) (block_comment)] @injection.language) .
        ([(string_literal) (raw_string_literal)] @injection.content))
        (#set! injection.combined))

      ((macro_invocation
         macro: (identifier) @_html (#eq? @_html "html")
         (token_tree) @injection.content)
       (#set! injection.language "html")
       (#set! injection.include-children))

      ((macro_invocation
        (token_tree) @injection.content)
       (#set! injection.language "rust")
       (#set! injection.include-children))

      ((macro_rule
        (token_tree) @injection.content)
       (#set! injection.language "rust")
       (#set! injection.include-children))

      (call_expression
        function: (scoped_identifier
          path: (identifier) @_regex (#eq? @_regex "Regex")
          name: (identifier) @_new (#eq? @_new "new"))
        arguments: (arguments (raw_string_literal) @injection.content)
        (#set! injection.language "regex"))

      (call_expression
        function: (scoped_identifier
          path: (scoped_identifier (identifier) @_regex (#eq? @_regex "Regex") .)
          name: (identifier) @_new (#eq? @_new "new"))
        arguments: (arguments (raw_string_literal) @injection.content)
        (#set! injection.language "regex"))

      ; Highlight SQL in `sqlx::query!()`, `sqlx::query_scalar!()`, and `sqlx::query_scalar_unchecked!()`
      (macro_invocation
        macro: (scoped_identifier
          path: (identifier) @_sqlx (#eq? @_sqlx "sqlx")
          name: (identifier) @_query (#match? @_query ""^query(_scalar|_scalar_unchecked)?$""))
        (token_tree
          ; Only the first argument is SQL
          .
          [(string_literal) (raw_string_literal)] @injection.content
        )
        (#set! injection.language "sql"))

      ; Highlight SQL in `sqlx::query_as!()` and `sqlx::query_as_unchecked!()`
      (macro_invocation
        macro: (scoped_identifier
          path: (identifier) @_sqlx (#eq? @_sqlx "sqlx")
          name: (identifier) @_query_as (#match? @_query_as ""^query_as(_unchecked)?$""))
        (token_tree
          ; Only the second argument is SQL
          .
          ; Allow anything as the first argument in case the user has lower case type
          ; names for some reason
          (_)
          [(string_literal) (raw_string_literal)] @injection.content
        )
        (#set! injection.language "sql"))
    '';
}
