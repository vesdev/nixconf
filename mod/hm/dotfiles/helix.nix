{ config, pkgs, ... }: {
  home.file.".config/helix/languages.toml".text = # toml
    ''
      [language-server.rust-analyzer.config.check]
      command = "clippy"

      [[language]]
      name = "nix"
      formatter = { command = "nixfmt" }
      auto-format = true

      [[language]]
      name = "markdown"
      language-servers = [ "marksman", "ltex-ls" ]
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

      [keys.insert]
      up = "no_op"
      down = "no_op"
      left = "no_op"
      right = "no_op"
      pageup = "no_op"
      pagedown = "no_op"
      home = "no_op"
      end = "no_op"
      "C-q" = "normal_mode"
      C-s = ":w"

      [editor]
      # mouse = false
      bufferline = "always"
      line-number = "relative"
      #fix ssh colors not working
      true-color = true

      [editor.cursor-shape]
      insert = "bar"
      normal = "bar"

      [editor.file-picker]
      hidden = false

      [editor.indent-guides]
      render = true
      character = "▏"
      # skip-levels = 1
    '';
}
