{ lib, ... }:

{
  imports = lib.whatever.getDefaultNixImports ./.;
}
