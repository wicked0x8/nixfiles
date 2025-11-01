{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.system.boot.grub;

in
{
  options.mine.system.boot.grub = {
    enable = mkEnableOption "enable grub bootloader";
  };

  config = mkIf cfg.enable {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
      enable = true;
      useOSProber = false;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };
}
