{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.amdgpu;
in
{
  options.mine.system.amdgpu = {
    enable = mkEnableOption "enable full amd support including drivers and vulkan";
  };

  config = mkIf cfg.enable {
    # Kernel AMDGPU driver loaded in initrd
    boot.initrd.kernelModules = [ "amdgpu" ];

    # Enable OpenGL, DRI, Vulkan, VA-API
    hardware.opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        mesa
        libva
        vulkan-tools
        amdvlk
      ];
    };

    # AMD GPU options: OpenCL and Vulkan drivers
    hardware.amdgpu = {
      opencl.enable = true;
      amdvlk.enable = true;
    };
  };
}

