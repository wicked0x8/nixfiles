{
  nixpkgs.url = "nixpkgs/nixos-unstable";

  nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-parts.url = "github:hercules-ci/flake-parts";
}

