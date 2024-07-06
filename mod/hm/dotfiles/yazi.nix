{ stdenv, pkgs, ... }:
{
  home.file.".config/yazi/filetree_config/yazi.toml".text = # toml
    ''
      [manager]
      ratio = [ 0, 8, 0 ]
    '';

  home.file.".config/yazi/filetree_config/keymap.toml".text = # toml
    ''
      [[manager.prepend_keymap]]
      on   = [ "l" ]
      run  = "plugin --sync smart-enter"
      desc = "Enter the child directory, or open the file"
    '';

  home.file.".config/yazi/filetree_config/plugins/smart-enter.yazi/init.lua".text = # lua
    ''
      return {
      	entry = function()
      		local h = cx.active.current.hovered
      		if h.cha.is_dir then
      			ya.manager_emit("enter" or "open", { hovered = true })
      			else
      				local hx_command = '\'\\e : o ' .. tostring(h.url) .. ' \\r\${"''"}
      				local command = 'kitten @ send-text --match neighbor:' .. 'right ' .. hx_command
      				os.execute(command)
      		end
      	end,
      }
    '';

  home.packages = [
    (pkgs.writeShellScriptBin "open_file_tree.bash" ''
      #!/usr/bin/env bash

      desired_width=25

      # Open window on the left
      YAZI_CONFIG_HOME=~/.config/yazi/filetree_config yazi

      # Use jq to filter the JSON output based on the specific window ID
      current_width=$(kitty @ ls | jq --arg window_id "$KITTY_WINDOW_ID" '.[].tabs[].windows[] | select(.id == ($window_id | tonumber)) | .columns')

      # Calculate the increment value
      increment=$((desired_width - current_width))

      # Resize the window with the calculated increment value
      kitten @ resize-window --increment $increment --axis horizontal
    '')
  ];
}
