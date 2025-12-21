{ lib, ... }:

# Credit: @JakeHamilton
# https://github.com/jakehamilton/config/blob/bf8411ec6b636f887dac45970864e09ba3ebf816/lib/module/default.nix
# Credit: @infinisil
# https://github.com/Infinisil/system/blob/df9232c4b6cec57874e531c350157c37863b91a0/config/new-modules/default.nix

with lib;
let
  ## Recursively get directory structure.
  ##
  ## ```nix
  ## getDir ./modules
  ## ```
  ##
  getDir =
    dir:
    mapAttrs (file: type: if type == "directory" then getDir "${dir}/${file}" else type) (
      builtins.readDir dir
    );

  ## Get all files in a directory recursively.
  ##
  ## ```nix
  ## files ./modules
  ## ```
  ##
  files =
    dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  ## Get all default.nix files in a directory recursively.
  ##
  ## ```nix
  ## getDefaultNix ./modules
  ## ```
  ##
  getDefaultNix =
    dir:
    builtins.map (file: dir + "/${file}") (
      builtins.filter (file: builtins.baseNameOf file == "default.nix") (files dir)
    );
in
{
  ## Create a NixOS module option.
  ##
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default" "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  ## Create a NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkOpt' nixpkgs.lib.types.str "My default"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt' = type: default: mkOpt type default null;

  ## Create a NixOS module option with no default
  ##
  ## ```nix
  ## lib.mkOpt_ types.path "Description of my option"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt_ = type: description: mkOption { inherit type description; };

  enabled = {
    ## Quickly enable an option.
    ##
    ## ```nix
    ## services.nginx = enabled;
    ## ```
    ##
    #@ true
    enable = true;
  };

  disabled = {
    ## Quickly disable an option.
    ##
    ## ```nix
    ## services.nginx = disabled;
    ## ```
    ##
    #@ false
    enable = false;
  };

  ## Recursively import all default.nix files from a directory.
  ##
  ## ```nix
  ## imports = lib.whatever.getDefaultNixImports ./.;
  ## ```
  ##
  getDefaultNixImports = getDefaultNix;
}
