{ stdenv, pkgs, ... }:
{
  home.file.".config/tridactyl/tridactylrc".text =
    ''
      set newtab about:blank
      set editorcmd kitty --class floatingAppFocus -e hx
      bind --mode=normal gi composite focusinput -l | editor

      unbind <c-e>
      unbind <C-b>

      bind <C-o> fillcmdline tabopen
      bind <C-j> fillcmdline tabopen
      bind <C-k> fillcmdline tabopen
      bind J tabnext
      bind K tabprev
    '';
}
