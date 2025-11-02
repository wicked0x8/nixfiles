{
  description = "my homemade nixos setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    mango.url = "github:dreammaomao/mango";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib.extend (self: super: {
      whatever = import ./lib {
        inherit inputs;
        lib = self;
      };
    });
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
    	system = "x86_64-linux";
    	specialArgs = {
      	  inherit inputs;
      	  inherit lib;
        };
        modules = [ ./hosts/laptop/configuration.nix inputs.mango.nixosModules.mango ];
      };
    };
  };
}
