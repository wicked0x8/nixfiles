{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.system.shell.bash;

in
{
  options.mine.system.shell.bash = {
    enable = mkEnableOption "bash shell";
  };

  config = mkIf cfg.enable {
    programs.bash.enable = true;
  };
}
