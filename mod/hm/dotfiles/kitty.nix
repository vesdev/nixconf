{ ... }:
{

  home.file.".config/kitty/kitty.conf".text = ''
    include ./theme.conf
    font_family FiraCode Nerd Font
    confirm_os_window_close 0
    enabled_layouts fat:bias=70;full_size=1;mirrored=false;,stack
    allow_remote_control yes
    map ctrl+shift+i new_window_with_cwd
    map ctrl+shift+q close_window
    map ctrl+shift+j next_window
    map ctrl+shift+k previous_window

    map --when-focus-on id:1 ctrl+shift+m combine : first_window : new_window_with_cwd
    map --when-focus-on id:2 ctrl+shift+m combine : second_window : close_other_windows_in_tab
  '';

  # map ctrl+shift+m toggle_layout stack
  home.file.".config/kitty/theme.conf".text = ''
    background #1c1e26
    foreground #e0e0e0

    cursor #d5d8da
    selection_background #353747

    color0 #16161c
    color8 #5b5858

    color1 #e95678
    color9 #ec6a88

    color2 #29d398
    color10 #3fdaa4

    color3 #fab795
    color11 #fbc3a7

    color4 #26bbd9
    color12 #3fc4de

    color5 #ee64ac
    color13 #f075b5

    color6 #59e1e3
    color14 #6be4e6

    color7 #d5d8da
    color15 #d5d8da

    selection_foreground #fab795
  '';
}
