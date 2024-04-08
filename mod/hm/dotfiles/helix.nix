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

      [[language]]
      name = "php"
      auto-format = true
      file-types = [ "php", "inc", "module" ]

      [language-server.intelephense.config]
      "includePaths" = [ "core/", "core/includes", "../vendor/" ]
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
      "'" = [ "repeat_last_motion" ]
      t = [ "trim_selections" ]
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
}
