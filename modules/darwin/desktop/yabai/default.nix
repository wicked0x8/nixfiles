{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.yabai;
in
{
  options.mine.desktop.yabai = {
    enable = mkEnableOption "yabai + skhd-zig";
  };
  config = mkIf cfg.enable {
    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;
      config = {
        layout = "bsp";
        window_gap = 10;
        top_padding = 12;
        bottom_padding = 12;
        left_padding = 12;
        right_padding = 12;
        window_border = "off";
        window_border_width = 2;
        mouse_follows_focus = "off";
        focus_follows_mouse = "autoraise";
      };
      extraConfig = ''
        yabai -m rule --add app="^System Settings$" manage=on
        yabai -m rule --add app="^Finder$" manage=on
        yabai -m rule --add app="^Activity Monitor$" manage=on
        yabai -m signal --add app='^Ghostty$' event=window_created action='yabai -m space --layout bsp'
        yabai -m signal --add app='^Ghostty$' event=window_destroyed action='yabai -m space --layout bsp'
        yabai -m rule --add app="^Ghostty$" subrole="AXFloatingWindow" manage=off
      '';
    };
    homebrew = {
      enable = true;
      brews = [ "jackielii/tap/skhd-zig" ];
    };
    launchd.user.agents.skhd-zig = {
      serviceConfig = {
        ProgramArguments = [ "/opt/homebrew/bin/skhd" ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/skhd.out.log";
        StandardErrorPath = "/tmp/skhd.err.log";
      };
    };
    home-manager.users.${user.name} = {
      home.file.".config/skhd/skhdrc".text = ''
        # ── Focus window (hjkl) ─────────────────────────────────────────
        alt - h : yabai -m window --focus west
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - l : yabai -m window --focus east

        # ── Swap window ──────────────────────────────────────────────────
        alt + shift - h : yabai -m window --swap west
        alt + shift - j : yabai -m window --swap south
        alt + shift - k : yabai -m window --swap north
        alt + shift - l : yabai -m window --swap east

        # ── Move window to space ─────────────────────────────────────────
        alt + shift - 1 : yabai -m window --space 1; yabai -m space --focus 1
        alt + shift - 2 : yabai -m window --space 2; yabai -m space --focus 2
        alt + shift - 3 : yabai -m window --space 3; yabai -m space --focus 3
        alt + shift - 4 : yabai -m window --space 4; yabai -m space --focus 4
        alt + shift - 5 : yabai -m window --space 5; yabai -m space --focus 5
        alt + shift - 6 : yabai -m window --space 6; yabai -m space --focus 6

        # ── Focus space ──────────────────────────────────────────────────
        alt - 1 : yabai -m space --focus 1
        alt - 2 : yabai -m space --focus 2
        alt - 3 : yabai -m space --focus 3
        alt - 4 : yabai -m space --focus 4
        alt - 5 : yabai -m space --focus 5
        alt - 6 : yabai -m space --focus 6

        # ── Resize ───────────────────────────────────────────────────────
        alt + ctrl - h : yabai -m window --resize left:-40:0; yabai -m window --resize right:-40:0
        alt + ctrl - j : yabai -m window --resize bottom:0:40; yabai -m window --resize top:0:40
        alt + ctrl - k : yabai -m window --resize top:0:-40;  yabai -m window --resize bottom:0:-40
        alt + ctrl - l : yabai -m window --resize right:40:0; yabai -m window --resize left:40:0

        # ── Float / fullscreen toggle ────────────────────────────────────
        alt - f : yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2
        alt - m : yabai -m window --toggle zoom-fullscreen

        # ── Layout toggles ───────────────────────────────────────────────
        alt - b : yabai -m space --layout bsp
        alt - s : yabai -m space --layout stack

        # ── Stack navigation ─────────────────────────────────────────────
        alt - n : yabai -m window --focus stack.next || yabai -m window --focus south
        alt - p : yabai -m window --focus stack.prev || yabai -m window --focus north

        # ── Rotate & mirror ──────────────────────────────────────────────
        alt - r : yabai -m space --rotate 90
        alt - y : yabai -m space --mirror y-axis
        alt - x : yabai -m space --mirror x-axis

        # ── Balance layout ───────────────────────────────────────────────
        alt - e : yabai -m space --balance

        # ── Close window ─────────────────────────────────────────────────
        alt - q : yabai -m window --close
      '';
    };
  };
}
