{ config, user, inputs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf types;
  inherit (config.mine) user;
  inherit (lib.whatever) mkOpt;
  cfg = config.mine.user.nix-colors;
in
{
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  options.mine.user.nix-colors = {
    enable = mkEnableOption "enable nix-colors";
    colorScheme = mkOpt types.str "nord" "nix-colors colorscheme";
  };

  config = mkIf cfg.enable {
    colorScheme = inputs.nix-colors.colorSchemes.${cfg.colorScheme};
  };
}
