{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  inherit (lib.whatever) mkOpt; # Verify this lib exists
  cfg = config.mine.system.utils;

  # Use rustup (includes cargo) - don't add cargo separately
  dev =
    with pkgs;
    lib.optionals cfg.dev [
      glow
      jq
      nixfmt
      nixpkgs-fmt
      shellcheck
      statix
      rustup # This includes cargo automatically
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
        # Base utils
        curl
        eza
        file
        fzf
        ripgrep
        tree
        unzip
        wget
        # Developer tools (conditionally)
      ]
      ++ dev;
  };
}
