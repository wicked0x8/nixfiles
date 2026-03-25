{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.mumble;

  murmurConfig = pkgs.writeText "murmur.ini" ''
    database=/var/lib/murmur/murmur.sqlite
    logfile=/var/log/murmur/murmur.log
    port=64738
    host=0.0.0.0
    serverpassword=${cfg.serverPassword}
    supw=${cfg.superUserPassword}
    allowping=true
    sslCert=/var/lib/murmur/murmur.crt
    sslKey=/var/lib/murmur/murmur.key
  '';
in
{
  options.mine.apps.mumble = {
    enable = mkEnableOption "mumble client";
    server = mkEnableOption "mumble server";
    serverPassword = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "pass to enter the server";
    };
    superUserPassword = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "SuperUser password";
    };
    serverBinaryPath = lib.mkOption {
      type = lib.types.str;
      default = "/usr/local/bin/murmurd";
      description = "path to the murmurd static binary";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      environment.systemPackages = [ pkgs.mumble ];
    })

    (lib.mkIf cfg.server {
      system.activationScripts.murmur = {
        text = ''
          mkdir -p /var/lib/murmur /var/log/murmur
          chown -R root:wheel /var/lib/murmur /var/log/murmur
        '';
      };

      launchd.daemons.murmur = {
        serviceConfig = {
          Label = "org.murmur.server";
          ProgramArguments = [
            cfg.serverBinaryPath
            "-ini"
            "${murmurConfig}"
            "-fg"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/var/log/murmur/murmur.log";
          StandardErrorPath = "/var/log/murmur/murmur.error.log";
          ThrottleInterval = 5;
        };
      };
    })
  ];
}
