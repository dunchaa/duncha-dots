{ pkgs, config, inputs, ... }:

let
  colors = import ../lib/palette.nix;

  # Store-paths вместо bare-имён — не зависит от $PATH,
  # пересобирается вместе с поколением.
  terminal   = "${pkgs.kitty}/bin/kitty";
  browser    = "${pkgs.brave}/bin/brave";
  fileman    = "${pkgs.kitty}/bin/kitty -e ${pkgs.yazi}/bin/yazi";
  rofi       = "${pkgs.rofi}/bin/rofi";
  cliphist   = "${pkgs.cliphist}/bin/cliphist";
  wlpaste    = "${pkgs.wl-clipboard}/bin/wl-paste";
  wlcopy     = "${pkgs.wl-clipboard}/bin/wl-copy";
  hyprshot   = "${pkgs.hyprshot}/bin/hyprshot";
  pamixer    = "${pkgs.pamixer}/bin/pamixer";
  bright     = "${pkgs.brightnessctl}/bin/brightnessctl";
  playerctl  = "${pkgs.playerctl}/bin/playerctl";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = ",preferred,auto,1";

      # Autorun
      exec-once = [
        "${wlpaste} --type text  --watch ${cliphist} store"
        "${wlpaste} --type image --watch ${cliphist} store"
        "swaync"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      # Wayland flags
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # Browsers / Electron
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "OZONE_PLATFORM,wayland"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"

        # GTK / Qt / SDL / Java
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,kvantum"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "SDL_VIDEODRIVER,wayland"
        "_JAVA_AWT_WM_NONREPARENTING,1"

        # Cursor
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "HYPRCURSOR_SIZE,24"
      ];

      # Input
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        off_window_axis_events = 2;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.7;
        };
      };

      # Gestures
      gestures = {
        workspace_swipe_distance = 700;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_create_new = true;
      };

      # General
      general = {
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;
        resize_on_border = true;
        no_focus_fallback = true;
        allow_tearing = true;
        layout = "dwindle";
        "col.active_border" = "rgba(${colors.mauve.hex}ff) rgba(${colors.sapphire.hex}ff) 45deg";
        "col.inactive_border" = "rgba(${colors.surface0.hex}cc)";

        snap = {
          enabled = true;
          window_gap = 4;
          monitor_gap = 5;
          respect_gaps = true;
        };
      };

      # Window Rules
      windowrulev2 = [
        "opacity 0.90 0.90,class:^(kitty)$"
        "float,class:^(polkit-kde-authentication-agent-1)$"
        "float,title:^(Open File)$"
        "noanim,class:^(swaync)$"

        # Picture-in-Picture (Firefox/Brave/Chromium)
        "float,         title:^(Picture-in-Picture)$"
        "pin,           title:^(Picture-in-Picture)$"
        "size 480 270,  title:^(Picture-in-Picture)$"
        "move 100%-w-20 100%-h-50, title:^(Picture-in-Picture)$"
      ];

      # Scratchpad — терминал на отдельном special-workspace.
      workspace = [
        "special:scratch, on-created-empty:${terminal}"
      ];

      # Decoration
      decoration = {
        rounding = 18;
        rounding_power = 2;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 10;
          passes = 3;
          brightness = 1.0;
          noise = 0.05;
          contrast = 0.89;
          vibrancy = 0.5;
          vibrancy_darkness = 0.5;
          popups = false;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          range = 20;
          offset = "0 2";
          render_power = 10;
        };

        dim_inactive = true;
        dim_strength = 0.05;
        dim_special = 0.2;
      };

      # Animations
      animations = {
        enabled = true;

        bezier = [
          "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
          "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
          "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "emphasizeAccel, 0.3, 0, 0.8, 0.15"
          "standartDecel, 0, 0, 0, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.52, 0.03, 0.72, 0.08"
          "stall, 1, -0.1, 0.7, 0.85"
        ];

        animation = [
          "windowsIn, 1, 3, emphasizedDecel, popin 80%"
          "fadeIn, 1, 3, emphasizedDecel"
          "windowsOut, 1, 2, emphasizedDecel, popin 90%"
          "fadeOut, 1, 2, emphasizedDecel"
          "windowsMove, 1, 3, emphasizedDecel, slide"
          "border, 1, 10, emphasizedDecel"
          "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
          "layersOut, 1, 2.4, menu_accel, popin 94%"
          "fadeLayersIn, 1, 0.5, menu_decel"
          "fadeLayersOut, 1, 2.7, stall"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
          "zoomFactor, 1, 3, standartDecel"
        ];
      };

      # Misc
      misc = {
        disable_hyprland_logo = true;
        vfr = true;
        vrr = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        focus_on_activate = true;
        enable_swallow = true;
        swallow_regex = "^(kitty|foot|Alacritty)$";
      };

      # Bindings
      "$mod" = "SUPER";

      bind = [
        # Exec
        "$mod,       RETURN, exec, ${terminal}"
        "$mod,       Q,      killactive,"
        "$mod,       W,      exec, ${browser}"
        "$mod,       F,      exec, ${fileman}"
        "$mod,       R,      exec, pkill rofi || ${rofi} -show drun"
        "$mod SHIFT, V,      exec, ${cliphist} list | ${rofi} -dmenu | ${cliphist} decode | ${wlcopy}"

        # Screenshots (hyprshot)
        ",           Print, exec, ${hyprshot} -m output"
        "$mod,       Print, exec, ${hyprshot} -m window"
        "$mod SHIFT, S,     exec, ${hyprshot} -m region"

        # Focus
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"

        # Move
        "$mod SHIFT, left,  swapwindow, l"
        "$mod SHIFT, right, swapwindow, r"
        "$mod SHIFT, up,    swapwindow, u"
        "$mod SHIFT, down,  swapwindow, d"

        # State management
        "$mod, D,     fullscreen, 0"
        "$mod, Space, togglefloating,"
        "$mod, P,     pin,"
        "$mod, J,     togglesplit"

        # Scratchpad
        "$mod,       grave, togglespecialworkspace, scratch"
        "$mod SHIFT, grave, movetoworkspace, special:scratch"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move window to another workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      binde = [
        "$mod CTRL, right, resizeactive,  10 0"
        "$mod CTRL, left,  resizeactive, -10 0"
        "$mod CTRL, up,    resizeactive,  0 -10"
        "$mod CTRL, down,  resizeactive,  0 10"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume,  exec, ${pamixer} -i 5"
        ", XF86AudioLowerVolume,  exec, ${pamixer} -d 5"
        ", XF86MonBrightnessUp,   exec, ${bright} s 5%+"
        ", XF86MonBrightnessDown, exec, ${bright} s 5%-"
      ];

      bindl = [
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioNext, exec, ${playerctl} next"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        ", XF86AudioMute, exec, ${pamixer} -t"
      ];
    };
  };

  # Без `with pkgs;` — иначе let-binding `hyprshot`/`pamixer` (строки-пути)
  # перекрывают атрибуты pkgs и home.packages получает строку, а не derivation.
  home.packages = [
    pkgs.hyprshot       # Screenshot tool
    pkgs.brightnessctl  # Brightness
    pkgs.pamixer        # Volume (используется в bindel/bindl)
  ];
}
