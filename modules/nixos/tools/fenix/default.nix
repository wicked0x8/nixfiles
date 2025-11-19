{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.fenix;
in
{
  options.mine.tools.fenix = {
    enable = mkEnableOption "enable user friendly fenix (rust)";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ (import ${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}) ];
    environment.systemPackages = with pkgs; [
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly
    ];
  };
}
