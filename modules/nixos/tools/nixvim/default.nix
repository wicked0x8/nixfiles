{ lib, config, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.nixvim;
in
{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ../../../nixvim/import.nix
  ];

  options.mine.tools.nixvim = {
    enable = mkEnableOption "nixvim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
    };
  };
}
