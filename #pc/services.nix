{ mod, ... }:
{
  hardware.keyboard.qmk.enable = true;
  services = {
    flatpak.enable = true;
    upower.enable = true;
    ratbagd.enable = true;
    # ollama = {
    #   enable = true;
    #   # acceleration = "cuda";
    #   acceleration = "rocm";
    #   # environmentVariables = {
    #   #   "CUDA_VISIBLE_DEVICES" = "0";
    #   # };
    #   rocmOverrideGfx = "10.3.0";
    # };

    postgresql = {
      enable = true;
      # ensureDatabases = [ "byteracer" "vueko" ];
      authentication = ''
        local all       postgres     trust
      '';
      identMap = ''
        superuser_map      ves      postgres
      '';
    };

    # rdt-client = {
    #   enable = true;
    #   package = mod.pkgs.rdt-client.override {
    #     appSettings = {
    #       Logging = {
    #         File = {
    #           Path = "/var/log/RdtClient/rdtclient.log";
    #           FileSizeLimitBytes = "5242889";
    #           MaxRollingFiles = "5";
    #         };
    #       };
    #       Database.Path = "/var/db/RdtClient/rdtclient.db";
    #       Port = 6500;
    #       BasePath = null;
    #     };
    #   };
    # };
  };
}
