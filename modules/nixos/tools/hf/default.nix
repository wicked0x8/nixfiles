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
    enable = mkEnableOption "enable huggingface cli and gradio for spaces";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [
        huggingface-hub
        gradio-client
        transformers
      ]))
    ];
  };
}
