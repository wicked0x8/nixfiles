{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.hf;

in
{
  options.mine.tools.hf = {
    enable = mkEnableOption "enable huggingface cli";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (python3.withPackages (ps: [
        ps.huggingface-hub
      ]))
    ];
  };
}
