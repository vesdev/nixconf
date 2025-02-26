{ ... }:
{
  services = {
    flatpak.enable = true;
    ratbagd.enable = true;
    ollama = {
      enable = true;
      acceleration = "cuda";
      environmentVariables = {
        "CUDA_VISIBLE_DEVICES" = "0";
      };
      # rocmOverrideGfx = "10.3.0";
    };

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
  };
}
