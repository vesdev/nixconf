{ mod, pkgs, ... }:
{ host, ... }:
let
  shellAliases = {
    nd = "nix develop";
    nl = "echo $SHLVL";
    ngc = "sudo nix-collect-garbage -d";
    lg = "lazygit";
    ls = "eza";
    ns = "sudo nixos-rebuild switch --flake .#${host}";
    cat = "bat";
    rg = "batgrep";
    cr = "clear && cargo run";
    scan = "iwctl station wlan0 scan";
    b = "buku";
    wun = ''PROTON_VERB="run GAMEID=0" PROTONPATH="GE-Proton" umu-run -SkipBuildPatchPrereq'';
    # fzf = ''sk --ansi -i -c 'rg --color=always --line-number "{}"'';
  };
in
{
  home.packages = [
    pkgs.man-pages

    (pkgs.writeShellApplication
      {
        name = "gpu2";
        text = # bash
          ''
            #!/usr/bin/env bash

            gpu="0000:05:00.0"
            aud="0000:05:00.1"
            usb="0000:05:00.2"
            bus="0000:05:00.3"

            gpu_vd="$(cat /sys/bus/pci/devices/$gpu/vendor) $(cat /sys/bus/pci/devices/$gpu/device)"
            aud_vd="$(cat /sys/bus/pci/devices/$aud/vendor) $(cat /sys/bus/pci/devices/$aud/device)"
            usb_vd="$(cat /sys/bus/pci/devices/$usb/vendor) $(cat /sys/bus/pci/devices/$usb/device)"
            bus_vd="$(cat /sys/bus/pci/devices/$bus/vendor) $(cat /sys/bus/pci/devices/$bus/device)"

            function bind_vfio {
              echo "$gpu" > "/sys/bus/pci/devices/$gpu/driver/unbind"
              echo "$aud" > "/sys/bus/pci/devices/$aud/driver/unbind"
              echo "$usb" > "/sys/bus/pci/devices/$usb/driver/unbind"
              echo "$bus" > "/sys/bus/pci/devices/$bus/driver/unbind"
              echo "$gpu_vd" > /sys/bus/pci/drivers/vfio-pci/new_id
              echo "$aud_vd" > /sys/bus/pci/drivers/vfio-pci/new_id
              echo "$usb_vd" > /sys/bus/pci/drivers/vfio-pci/new_id
              echo "$bus_vd" > /sys/bus/pci/drivers/vfio-pci/new_id
            }
 
            function unbind_vfio {
              echo "$gpu_vd" > "/sys/bus/pci/drivers/vfio-pci/remove_id"
              echo "$aud_vd" > "/sys/bus/pci/drivers/vfio-pci/remove_id"
              echo "$usb_vd" > "/sys/bus/pci/drivers/vfio-pci/remove_id"
              echo "$bus_vd" > "/sys/bus/pci/drivers/vfio-pci/remove_id"
              echo 1 > "/sys/bus/pci/devices/$gpu/remove"
              echo 1 > "/sys/bus/pci/devices/$aud/remove"
              echo 1 > "/sys/bus/pci/devices/$usb/remove"
              echo 1 > "/sys/bus/pci/devices/$bus/remove"
              echo 1 > "/sys/bus/pci/rescan"
            }

            if [[ "$1" == "unbind" ]]; then
              unbind_vfio
            fi

            if [[ "$1" == "bind" ]]; then
              bind_vfio
            fi
          '';
      })
  ];

  programs = {
    zoxide.enable = true;
    zoxide.enableFishIntegration = true;
    # fish.enable = true;
    fish = {
      enable = true;
      inherit shellAliases;


      # export MANPAGER="sh -c 'col -bx | bat -l man -p'"

      interactiveShellInit = ''
        set -gx fish_key_bindings fish_vi_key_bindings
        set -gx XDG_DATA_DIRS $XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
        set -gx PATH $PATH /var/lib/flatpak/exports/bin
        set -gx VIRSH_DEFAULT_CONNECT_URI qemu:///system

        set -gx MANPAGER "less -R --use-color -Dd+r -Du+b"
        set -gx MANROFFOPT '-c'
      '';

    };
    # bash = {
    #   enable = true;
    #   inherit shellAliases;


    #   # export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    #   bashrcExtra = ''
    #     export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    #     export PATH=$PATH:/var/lib/flatpak/exports/bin
    #     export VIRSH_DEFAULT_CONNECT_URI=qemu:///system

    #     export MANPAGER="less -R --use-color -Dd+r -Du+b"
    #     export MANROFFOPT='-c'
    #   '';
    # };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
