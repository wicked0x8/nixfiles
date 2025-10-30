{ lib, config, ... }:
let

  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt;
  cfg = config.mine.system.timezone;

in
{
  options.mine.system.timezone = {
    enable = mkOpt types.bool true "enable time";
    location = mkOpt types.str "Asia/Yekaterinburg" "timezone location";
  };

  config = mkIf cfg.enable {
    time.timeZone = "${cfg.location}";
  };
}
