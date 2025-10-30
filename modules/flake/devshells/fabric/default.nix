{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.devshells.fabric;
in
{
  options.mine.devshells.fabric = {
    enable = mkEnableOption "enable fabric devshell";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
      python3Packages.pygobject3
      python3Packages.fabric
      gtk3
      cairo
    ];

    # Optional: shell hook to notify devshell usage
    environment.shellInit = ''
      echo "fabric devshell enabled"
      export PYTHONPATH=${pkgs.python3Packages.pygobject3}/lib/python3.*/site-packages
    '';
  };
}
