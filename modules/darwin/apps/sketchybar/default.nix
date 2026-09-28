{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.apps.sketchybar;

  ef = {
    bg0 = "0xff232b2e";
    bg1 = "0xff2a3336";
    bg2 = "0xff313d40";
    bg3 = "0xff3a4649";
    bg4 = "0xff434e51";
    fg = "0xffd8cab8";
    red = "0xffe07070";
    orange = "0xffe69875";
    yellow = "0xffdbbc7f";
    green = "0xffa7c080";
    aqua = "0xff83c092";
    blue = "0xff7fbbb3";
    purple = "0xffd699b6";
    bg0_t80 = "0xcc232b2e";
  };

  batteryScript = pkgs.writeShellScript "sketchybar-battery" ''
    PCT=$(pmset -g batt | grep -o "[0-9]*%" | head -1 | tr -d "%")
    CHARGING=$(pmset -g batt | grep -c "AC Power" || true)
    if [ "$CHARGING" -gt 0 ]; then
      ICON="󰂄"; COLOR="${ef.green}"
    elif [ "$PCT" -gt 80 ]; then
      ICON="󰁹"; COLOR="${ef.green}"
    elif [ "$PCT" -gt 50 ]; then
      ICON="󰁾"; COLOR="${ef.yellow}"
    elif [ "$PCT" -gt 20 ]; then
      ICON="󰁻"; COLOR="${ef.orange}"
    else
      ICON="󰁺"; COLOR="${ef.red}"
    fi
    sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="''${PCT}%"
  '';

  volumeScript = pkgs.writeShellScript "sketchybar-volume" ''
    VOL=$(osascript -e "output volume of (get volume settings)")
    MUTED=$(osascript -e "output muted of (get volume settings)")
    if [ "$MUTED" = "true" ]; then
      ICON="󰖁"
    elif [ "$VOL" -gt 60 ]; then
      ICON="󰕾"
    elif [ "$VOL" -gt 30 ]; then
      ICON="󰖀"
    else
      ICON="󰕿"
    fi
    sketchybar --set "$NAME" icon="$ICON" label="''${VOL}%"
  '';

  wifiScript = pkgs.writeShellScript "sketchybar-wifi" ''
    IP=$(/usr/sbin/ipconfig getifaddr en0 2>/dev/null)
    if [ -z "$IP" ]; then
      sketchybar --set "$NAME" icon=󰖪 icon.color="${ef.red}" label="off"
    else
      sketchybar --set "$NAME" icon=󰖩 icon.color="${ef.blue}" label="$IP"
    fi
  '';

  weatherScript = pkgs.writeShellScript "sketchybar-weather" ''
    DATA=$(curl -sf "https://wttr.in/?format=%c+%t" 2>/dev/null | tr -d '+')
    if [ -z "$DATA" ]; then
      sketchybar --set "$NAME" label="--"
    else
      sketchybar --set "$NAME" label="$DATA"
    fi
  '';

  clockScript = pkgs.writeShellScript "sketchybar-clock" ''
    sketchybar --set "$NAME" label="$(date '+%a %d %b %H:%M')"
  '';

  frontAppScript = pkgs.writeShellScript "sketchybar-front-app" ''
    APP_PATH=$(mdfind "kMDItemContentType == 'com.apple.application-bundle' && kMDItemDisplayName == '$INFO'" 2>/dev/null | head -1)
    if [ -n "$APP_PATH" ]; then
      sketchybar --set "$NAME" label="$INFO" icon.image="$APP_PATH"
    else
      sketchybar --set "$NAME" label="$INFO"
    fi
  '';

  spaceScript = pkgs.writeShellScript "sketchybar-space" ''
    sketchybar --set "$NAME" \
      background.color="${ef.bg3}" \
      icon.color="${ef.aqua}"
  '';
in
{
  options.mine.apps.sketchybar = {
    enable = mkEnableOption "sketchybar, the menu bar replacement";
  };

  config = mkIf cfg.enable {
    homebrew = {
      taps = [ "FelixKratz/formulae" ];
      brews = [
        "FelixKratz/formulae/sketchybar"
        "nowplaying-cli"
      ];
      casks = [ "font-jetbrains-mono-nerd-font" ];
    };

    launchd.user.agents.sketchybar = {
      serviceConfig = {
        ProgramArguments = [ "/opt/homebrew/bin/sketchybar" ];
        EnvironmentVariables = {
          HOME = "/Users/${user.name}";
          PATH = "/opt/homebrew/bin:/usr/bin:/bin";
        };
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/sketchybar.out.log";
        StandardErrorPath = "/tmp/sketchybar.err.log";
      };
    };

    home-manager.users.${user.name} = {
      home.file.".config/sketchybar/sketchybarrc" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          FONT="JetBrainsMono Nerd Font"

          sketchybar --bar \
            height=32 \
            position=top \
            sticky=on \
            padding_left=10 \
            padding_right=10 \
            color=${ef.bg0_t80} \
            border_width=1 \
            border_color=${ef.bg4} \
            shadow=off \
            topmost=window \
            corner_radius=0

          sketchybar --default \
            updates=when_shown \
            icon.font="$FONT:Bold:14.0" \
            icon.color=${ef.green} \
            icon.padding_left=6 \
            icon.padding_right=4 \
            label.font="$FONT:Regular:12.0" \
            label.color=${ef.fg} \
            label.padding_left=4 \
            label.padding_right=8 \
            background.color=${ef.bg2} \
            background.border_color=${ef.bg4} \
            background.border_width=1 \
            background.corner_radius=6 \
            background.height=24 \
            background.padding_left=2 \
            background.padding_right=2

          # ── LEFT ────────────────────────────────────────────────────────

          sketchybar --add item apple left \
            --set apple \
              icon= \
              icon.color=${ef.green} \
              icon.font="$FONT:Bold:16.0" \
              label.drawing=off \
              background.drawing=off \
              padding_left=6 \
              padding_right=6 \
              click_script="sketchybar --update"

          for i in $(seq 1 9); do
            sketchybar --add space space.$i left \
              --set space.$i \
                associated_space=$i \
                icon=$i \
                icon.highlight_color=${ef.aqua} \
                label.drawing=off \
                background.color=${ef.bg2} \
                background.border_color=${ef.bg4} \
                background.corner_radius=6 \
                script="${spaceScript}" \
                click_script="yabai -m space --focus $i"
            sketchybar --subscribe space.$i space_change
          done

          sketchybar --add item front_app left \
            --set front_app \
              icon.drawing=on \
              icon.image.scale=0.8 \
              label.color=${ef.yellow} \
              label.font="$FONT:Bold:12.0" \
              background.color=${ef.bg2} \
              background.border_color=${ef.bg4} \
              background.corner_radius=6 \
              script="${frontAppScript}" \
            --subscribe front_app front_app_switched

          # ── CENTER ──────────────────────────────────────────────────────

          sketchybar --add item clock center \
            --set clock \
              update_freq=10 \
              icon= \
              icon.color=${ef.blue} \
              background.color=${ef.bg2} \
              background.border_color=${ef.bg4} \
              background.corner_radius=6 \
              script="${clockScript}"

          # ── RIGHT ───────────────────────────────────────────────────────

          sketchybar --add item weather right \
            --set weather \
              update_freq=900 \
              icon=󰖐 \
              icon.color=${ef.blue} \
              background.color=${ef.bg2} \
              background.border_color=${ef.bg4} \
              background.corner_radius=6 \
              script="${weatherScript}"

          sketchybar --add item wifi right \
            --set wifi \
              update_freq=30 \
              icon=󰖩 \
              icon.color=${ef.blue} \
              background.color=${ef.bg2} \
              background.border_color=${ef.bg4} \
              background.corner_radius=6 \
              script="${wifiScript}"

          sketchybar --add item volume right \
            --set volume \
              icon.color=${ef.aqua} \
              background.color=${ef.bg2} \
              background.border_color=${ef.bg4} \
              background.corner_radius=6 \
              script="${volumeScript}" \
            --subscribe volume volume_change

          sketchybar --add item battery right \
            --set battery \
              update_freq=60 \
              icon.color=${ef.yellow} \
              background.color=${ef.bg2} \
              background.border_color=${ef.bg4} \
              background.corner_radius=6 \
              script="${batteryScript}"

          sketchybar --update
        '';
      };
    };
  };
}
