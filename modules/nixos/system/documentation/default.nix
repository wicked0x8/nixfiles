{ lib, config, ... }:
let
  inherit (lib.whatever) mkOpt;
  inherit (lib) mkIf types;
in
{
  options.mine.system.documentation = {
    enable = mkOpt types.bool true "enable NixOS documentation";
  };

  config = let
    cfg = config.mine.system.documentation;
  in mkIf (!cfg.enable) {
    documentation.nixos.enable = false;
  };
}