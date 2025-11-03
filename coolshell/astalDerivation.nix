{
  packages.${system}.default = pkgs.stdenvNoCC.mkDerivation { 
      name = "coolshell";
      src = ./.;

      nativeBuildInputs = [
        pkgs.wrapGAppsHook3
        pkgs.gobject-introspection
        pkgs.esbuild
	pkgs.meson
    	pkgs.ninja
    	pkgs.pkg-config
      ];

      buildInputs = [
        pkgs.gjs
        pkgs.glib
        pkgs.gtk4
        astal.packages.${system}.io
        astal.packages.${system}.astal4
      ];

      installPhase = ''
        mkdir -p $out/bin

        esbuild \
          --bundle src/app.js \
          --outfile=$out/bin/my-shell \
          --format=esm \
          --sourcemap=inline \
          --external:gi://\*
      '';
    };
}
