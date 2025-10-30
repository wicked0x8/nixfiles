{ pkgs, lib, ... }:
{
  laptop = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
      inherit lib;
    };
    modules = [ ./laptop/configuration.nix ];
  };
}
