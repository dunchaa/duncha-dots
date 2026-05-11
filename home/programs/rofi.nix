{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font 14";

    extraConfig = {
      modi = "drun,run,window"; # Run apps, run scripts, search windows
      show-icons = true;
      icon-theme = "Papirus-Dark";
      terminal = "kitty";

      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      case-sensitive = false;

      display-drun = " Apps ";
      display-run = " Run ";
      display-window = " Window ";
    };
  };

  home.packages = with pkgs; [
    cliphist # Clipboard manager
    wtype    # Needed for cliphist
  ];
}

