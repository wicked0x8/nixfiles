{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.zapret;
in
{
  options.mine.services.zapret = {
    enable = mkEnableOption "enable zapret";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zapret ];
    services.zapret = {
      enable = true;
      params = ''
        [
	  --filter-tcp=443
	  --dpi-desync=fake,fakeddisorder
	  --dpi-desync-split-pos=10,midsld
	  --dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin
	  --dpi-desync-fake-tls-mod=rnd,dupsid,sni=fonts.google.com
	  --dpi-desync-fake-tls=0x0F0F0F0F
	  --dpi-desync-fake-tls-mod=none
	  --dpi-desync-fakedsplit-pattern=/opt/zapret/files/fake/tls_clienthello_vk_com.bin
	  --dpi-desync-split-seqovl=336
	  --dpi-desync-split-seqovl-pattern=/opt/zapret/files/fake/tls_clienthello_gosuslugi_ru.bin
	  --dpi-desync-fooling=badseq,badsum
	  --dpi-desync-badseq-increment=0
	  --new
	  --filter-udp=443
	  --dpi-desync=fake
	  --dpi-desync-repeats=4 
	  --dpi-desync-fake-quic=/opt/zapret/files/fake/quic_initial_www_google_com.bin
	]
      '';
    };
  };
}



