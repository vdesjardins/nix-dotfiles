{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  mod = "Mod4";

  wallpaperName = "wallhaven-wq1wlr.jpg";
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/wq/wallhaven-wq1wlr.jpg";
    hash = "sha256-FcBT/iyL9erjyk+iZ6b1OLJ+lB7N5IUVXWdMxmmUnDk=";
  };

  locker = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
  terminal = "wezterm";

  modeGaps = "Gaps: (o) outer, (i) inner";
  modeGapInner = "Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)";
  modeGapsOuter = "Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)";

  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";

  cfg = config.wayland.windowManager.mySway;
in {
  options.wayland.windowManager.mySway = {
    enable = mkEnableOption "mySway";
    font = mkOption {
      type = types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;

      config = {
        modifier = mod;

        input = {
          "*" = {
            xkb_layout = "us,ca";
            xkb_variant = "fr";
            xkb_options = "grp:alt_space_toggle,caps:ctrl_modifier";
            xkb_model = "pc104";
            repeat_delay = "200";
            repeat_rate = "35";
          };
        };

        output = {
          "Virtual-1" = {
            mode = "3840x2160@60Hz";
          };
          "*" = {
            background = "~/.config/wallpapers/${wallpaperName} fill";
          };
        };

        defaultWorkspace = "workspace ${ws1}";

        workspaceAutoBackAndForth = true;

        menu = "wofi -show drun";

        focus = {
          followMouse = true;
          mouseWarping = "container";
        };

        bars = [
          {
            colors = {
              background = "#1c1c22";
              focusedWorkspace = {
                border = "#7592af";
                background = "#2e3440";
                text = "#ffffff";
              };
            };

            fonts = {
              names = [cfg.font];
              size = 12.0;
            };

            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
          }
        ];

        fonts = {
          names = [cfg.font];
          size = 10.0;
        };

        gaps = {
          inner = 5;
          smartBorders = "on";
          outer = 5;
        };

        inherit terminal;

        window = {
          titlebar = false;
          border = 2;
        };

        keybindings = lib.mkOptionDefault {
          # Focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+g" = "exec ${pkgs.wmfocus}/bin/wmfocus";

          # Move
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # Move to workspace
          "${mod}+1" = "workspace ${ws1}";
          "${mod}+2" = "workspace ${ws2}";
          "${mod}+3" = "workspace ${ws3}";
          "${mod}+4" = "workspace ${ws4}";
          "${mod}+5" = "workspace ${ws5}";
          "${mod}+6" = "workspace ${ws6}";
          "${mod}+7" = "workspace ${ws7}";
          "${mod}+8" = "workspace ${ws8}";
          "${mod}+9" = "workspace ${ws9}";
          "${mod}+0" = "workspace ${ws10}";

          # Move container to workspace
          "${mod}+Shift+1" = "move container to workspace ${ws1}";
          "${mod}+Shift+2" = "move container to workspace ${ws2}";
          "${mod}+Shift+3" = "move container to workspace ${ws3}";
          "${mod}+Shift+4" = "move container to workspace ${ws4}";
          "${mod}+Shift+5" = "move container to workspace ${ws5}";
          "${mod}+Shift+6" = "move container to workspace ${ws6}";
          "${mod}+Shift+7" = "move container to workspace ${ws7}";
          "${mod}+Shift+8" = "move container to workspace ${ws8}";
          "${mod}+Shift+9" = "move container to workspace ${ws9}";
          "${mod}+Shift+0" = "move container to workspace ${ws10}";

          # Move container to workspace and focus
          "${mod}+Control+1" = "move container to workspace ${ws1}; workspace ${ws1}";
          "${mod}+Control+2" = "move container to workspace ${ws2}; workspace ${ws2}";
          "${mod}+Control+3" = "move container to workspace ${ws3}; workspace ${ws3}";
          "${mod}+Control+4" = "move container to workspace ${ws4}; workspace ${ws4}";
          "${mod}+Control+5" = "move container to workspace ${ws5}; workspace ${ws5}";
          "${mod}+Control+6" = "move container to workspace ${ws6}; workspace ${ws6}";
          "${mod}+Control+7" = "move container to workspace ${ws7}; workspace ${ws7}";
          "${mod}+Control+8" = "move container to workspace ${ws8}; workspace ${ws8}";
          "${mod}+Control+9" = "move container to workspace ${ws9}; workspace ${ws9}";
          "${mod}+Control+0" = "move container to workspace ${ws10}; workspace ${ws10}";

          # Move workspace between screens
          "${mod}+Control+j" = "move workspace to output left";
          "${mod}+Control+semicolon" = "move workspace to output right";

          # fullscreen
          "${mod}+f" = "fullscreen";

          # start a terminal
          "${mod}+Return" = "exec ${terminal}";

          # lock screen
          "${mod}+Shift+x" = "exec --no-startup-id ${locker}";

          # toggle tiling / floating
          "${mod}+Shift+space" = "floating toggle";

          # move the currently focused window to the scratchpad
          "${mod}+Shift+minus" = "move scratchpad";

          # Show the next scratchpad window or hide the focused scratchpad window.
          # If there are multiple scratchpad windows, this command cycles through them.
          "${mod}+minus" = "scratchpad show";

          # Multimedia Key Controls from https://faq.i3wm.org/question/3747/enabling-multimedia-keys/?answer=3759#post-id-3759
          # Pulse Audio controls
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%"; #increase sound volume
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%"; #decrease sound volume
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle"; # mute sound

          # Sreen brightness controls
          "XF86MonBrightnessUp" = "exec brightnessctl set +50"; # increase screen brightness
          "XF86MonBrightnessDown" = "exec brightnessctl set 50-"; # decrease screen brightness

          # Media player controls
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";

          # Screenshots
          "${mod}+p" = "exec --no-startup-id shotman --capture window --copy";
          "${mod}+Shift+p" = "exec --no-startup-id shotman --capture region --copy";
          "${mod}+Ctrl+p" = "exec --no-startup-id shotman --capture output --copy";

          # clipboard
          "${mod}+Shift+c" = ''exec "wofi 'clipboard:greenclip print' --show clipboard"'';

          # Press $mod+Shift+g to enter the gap mode. Choose o or i for modifying outer/inner Gaps.
          # Press one of + / - (in-/decrement for current workspace) or 0 (remove gaps for current workspace).
          # If you also press Shift with these keys, the change will be global for all workspaces.
          "${mod}+Shift+g" = "mode \"${modeGaps}\"";

          # Wofi window switcher
          "${mod}+Shift+d" = "exec wofi --show window";

          # Wofi combi switcher
          "${mod}+Shift+o" = "exec wofi --show combi";

          # Launch Browser
          "${mod}+b" = "exec firefox";

          # rename current workspace
          "${mod}+comma" = "exec echo \"\" | wofi --dmenu -p 'New workspace name' | xargs -r swaymsg rename workspace to";
          # rename current window
          "${mod}+period" = "exec echo \"\" | wofi --dmenu -p 'New window name' | xargs -r swaymsg rename window to";
          # kill app
          "${mod}+Shift+q" = "kill";

          # Enable/disable logging
          "${mod}+x" = "shmlog toggle";

          # quick shortcut help
          "${mod}+Shift+question" = "exec --no-startup-id swaycheatsheet-win";
        };

        modes = lib.mkOptionDefault {
          "${modeGaps}" = {
            i = "mode \"${modeGapInner}\"";
            o = "mode \"${modeGapsOuter}\"";
            Return = "mode default";
            Escape = "mode default";
          };
          "${modeGapInner}" = {
            plus = "gaps inner current plus 5";
            minus = "gaps inner current minus 5";
            "0" = "gaps inner current set 0";

            "Shift+plus" = "gaps inner all plus 5";
            "Shift+minus" = "gaps inner all minus 5";
            "Shift+0" = "gaps inner all set 0";

            Return = "mode default";
            Escape = "mode default";
          };
          "${modeGapsOuter}" = {
            plus = "gaps outer current plus 5";
            minus = "gaps outer current minus 5";
            "0" = "gaps outer current set 0";

            "Shift+plus" = "gaps outer all plus 5";
            "Shift+minus" = "gaps outer all minus 5";
            "Shift+0" = "gaps outer all set 0";

            Return = "mode default";
            Escape = "mode default";
          };
        };

        startup = [
          {
            command = "mako";
          }
          {
            command = "udiskie";
          }
          {
            command = "autotiling";
            always = true;
          }
        ];
      };

      extraConfig = ''
        # quick shortcut help
        for_window [title="Sway Shortcuts"] floating enable, move absolute position center, resize grow left 318, resize grow right 318, resize grow down 20, resize grow up 20
      '';
    };

    xdg.configFile."wallpapers/${wallpaperName}".source = wallpaper;

    home.packages = with pkgs; [
      autotiling
      (writeScriptBin
        "swaycheatsheet"
        ''
          #!${runtimeShell}

          ${gnugrep}/bin/grep -E "^bindsym" ~/.config/sway/config | ${gawk}/bin/awk '{$1=""; print $0}' | ${gnused}/bin/sed 's/^ *//g' | ${gnugrep}/bin/grep -vE "^XF86" | ${unixtools.column}/bin/column -t -l2 | ${coreutils}/bin/pr -2 -w 160 -t | ${less}/bin/less
        '')
      (writeScriptBin
        "swaycheatsheet-win"
        ''
          #!${runtimeShell}

          title="Sway Shortcuts"
          alacritty -T "$title" -e swaycheatsheet
        '')
    ];
  };
}
