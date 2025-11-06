{
  lib,
  config,
  inputs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.screenshot;

in
{
  options.mine.tools.screenshot = {
    enable = mkEnableOption "grim+slurp+swappy";
  };

  imports = [
    inputs.nixvim.nixosModules.nixvim
    ../../../nixvim/import.nix
  ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };
}
