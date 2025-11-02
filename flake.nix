{
  description = "My homemade NixOS flake with modular hierarchy";

  inputs = import ./modules/flake/inputs.nix;

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (parts: {
      imports = [ ./hosts/nixosConfigurations.nix ];

      systems = [ "x86_64-linux" ];

      perSystem = {
        x86_64-linux = { pkgs, lib, ... }: {
          nixosConfigurations = parts.imports;
        };
      };
    });
}

