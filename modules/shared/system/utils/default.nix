{ lib, config, pkgs, ...}:

with lib; let
  inherit (lib.whatever) mkOpt;
  cfg = config.mine.system.utils;
  dev = with pkgs; [
    glow
    jq
    nixfmt-rfc-style
    nixpkgs-fmt
    shellcheck
    statix
  ];
in

{
  options.mine.system.utils = {
    enable = mkOpt types.bool true "system utils";
    dev = mkEnableOption "developer focused tooling";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        curl
        eza
        file
        fzf
        ripgrep
        tree
        unzip
        wget
      ];
  };
}
