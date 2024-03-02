{ mod, ... }: {
  # imports = [ mod.nixosModules.pipewire ];

  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # lowLatency = {
    #   enable = true;
    #   quantum = 48; # tweak for less latency, too low will crackle
    #   rate = 48000;
    # };
  };
}
