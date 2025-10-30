{ lib, config, inputs, ...}:
let
  inherit (lib) mkIf;
  inherit (config.mine) user;
  cfg = config.mine.user.home-manager;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
        inherit user;
      };
      users.${user.name}.imports = [ ./home.nix ];
    };
  };
}
