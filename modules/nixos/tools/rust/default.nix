{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.rust;

in
{
  options.mine.tools.rust = {
    enable = mkEnableOption "install rustup and cargo";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rustup cargo ];
  };
}
