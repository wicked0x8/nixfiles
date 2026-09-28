{ lib, pkgs, config, ... }:
let
  inherit (lib.whatever) mkOpt;
  inherit (lib) mkOption mkIf types;
in

{
  options.mine.user = {
    enable = mkOpt types.bool false "enable user";
    name = mkOpt types.str "dubbber" "user account name";
    email = mkOpt types.str "scorpionolegovich@gmail.com" "user account email";
    home-dir = mkOpt types.str ("/home/" + config.mine.user.name) "user home directory";
    home-manager.enable = mkOpt types.bool false "enable home-manager";
    shell = mkOption {
      default = { };
      description = "shell config for user";
      type = types.submodule {
        options = {
          package = mkOpt types.package pkgs.bash "user shell";
        };
      };
    };
  };

  config = mkIf config.mine.user.enable {
    mine.system.shell = {
      zsh.enable = mkIf (config.mine.user.shell.package == pkgs.zsh) true;
      bash.enable = mkIf (config.mine.user.shell.package == pkgs.bash) true;
    };

    nix.settings.trusted-users = [ config.mine.user.name ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/current-system/sw/bin"
    '';

    users.groups.${config.mine.user.name} = { };

    users.users.${config.mine.user.name} = {
      isNormalUser = true;
      createHome = true;
      group = config.mine.user.name;
      extraGroups = [ "wheel" "input" "storage" "bluetooth" "video" "audio" "render" ];
      shell = config.mine.user.shell.package;
    };
  };
}

