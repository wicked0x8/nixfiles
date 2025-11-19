{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.tun2socks;

in
{
  options.mine.tools.tun2socks = {
    enable = mkEnableOption "enable tun2socks";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ tun2socks ];
  };
}
