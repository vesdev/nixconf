{ pkgs, ... }:
let
  lldb-script = pkgs.writeScriptBin "lldb_vscode_rustc_primer.py" ''
    import subprocess
    import pathlib
    import lldb

    # Determine the sysroot for the active Rust interpreter
    rustlib_etc = pathlib.Path(subprocess.getoutput('rustc --print sysroot')) / 'lib' / 'rustlib' / 'etc'
    if not rustlib_etc.exists():
        raise RuntimeError('Unable to determine rustc sysroot')

    # Load lldb_lookup.py and execute lldb_commands with the correct path
    lldb.debugger.HandleCommand(f"""command script import "{rustlib_etc / 'lldb_lookup.py'}" """)
    lldb.debugger.HandleCommand(f"""command source -s 0 "{rustlib_etc / 'lldb_commands'}" """)
  '';
in
{
  home.file.".config/helix/languages.toml".text = # toml
    ''
      [[language]]
      name = "rust"

      [language.debugger]
      name = "lldb-vscode"
      transport = "stdio"
      command = "lldb-vscode"

      [[language.debugger.templates]]
      name = "binary"
      request = "launch"
      completion = [ { name = "binary", completion = "filename" } ]
      args = { program = "{0}", initCommands = [ "command script import ${lldb-script}" ] }

      [language-server.rust-analyzer.config]
      procMacro = { ignored = { leptos_macro = [
          # Optional:
          # "component",
          # "server"
      ] } } 
      cargo = { features = "all" }
      check = { command = "clippy" }

      [[language]]
      name = "nix"
      formatter = { command = "nixpkgs-fmt" }
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
      includePaths = [ "core/", "core/includes", "../vendor/" ]

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
      shell = ["fish", "-c"]
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

      [editor.inline-diagnostics]
      cursor-line = "error"
      # other-lines = "error"
    '';
}
