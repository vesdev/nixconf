{ ... }: {
  home.file.".config/kitty/kitty.conf".text = ''
    include ./theme.conf
    font_family FiraCode Nerd Font
    confirm_os_window_close 0
  '';
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
