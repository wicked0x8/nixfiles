{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let

  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;

  home-directory = "/Users/${user.name}";

in
{
  options.mine.user = {
    enable = mkEnableOption "Enable User";
    name = mkOpt types.str "wicked" "User account name";
    alias = mkOpt types.str "wicked" "My full alias";
    email = mkOpt types.str "scorpionolegovich@gmail.com" "My Email";
    homeDir = mkOpt types.str "${home-directory}" "Home Directory Path";
    home-manager.enable = mkOpt types.bool false "Enable home-manager";
    shell = mkOption {
      default = { };
      description = "Shell config for user";
      type = types.submodule {
        options = {
          package = mkOpt types.package pkgs.bash "User shell";
        };
      };
    };
  };

  config = mkIf user.enable {
    users.knownUsers = [ "${user.name}" ];

    users.users.${user.name} = {
      name = "${user.name}";
      home = "${user.homeDir}";
      isHidden = false;
      shell = user.shell.package;
      uid = 501;
    };
  };
}
