{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.adguard-vpn;

in
{
  options.mine.apps.adguard-vpn = {
    enable = mkEnableOption "adguard-vpn";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "adguard-vpn@nightly" ];
  };
}
