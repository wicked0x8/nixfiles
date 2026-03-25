{
  config,
  inputs,
  lib,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.nixvim;

in
{
  options.mine.tools.nixvim = {
    enable = mkEnableOption "install nixvim";
  };

  imports = [
    inputs.nixvim.nixDarwinModules.nixvim
    ../../../nixvim/import.nix
  ];

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
    };
  };
}
