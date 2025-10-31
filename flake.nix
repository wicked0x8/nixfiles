{
  description = "my homemade nixos setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, home-manager, mango,  ... }@inputs:
  let
    lib = nixpkgs.lib.extend (self: super: {
      whatever = import ./lib {
        inherit inputs;
        lib = self;
      };
    });
  in {
    nixosConfigurations = {
      nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
        ];
        specialArgs = {
          inherit inputs lib;
        };
      };
    };
  };
}

