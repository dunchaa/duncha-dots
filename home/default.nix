{ config, pkgs, user, inputs, ... }:

{
  imports = [
    #./desktop/ags.nix
    ./desktop/hypridle.nix
    ./desktop/hyprland.nix
    ./desktop/hyprlock.nix
    ./desktop/hyprpaper.nix
    ./desktop/swaync.nix
    ./programs/rofi.nix
    ./programs/shell.nix
    ./programs/terminal.nix
    ./programs/yazi.nix
  ];

  # User
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # Global theme settings
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };
  
  # Cursor settings
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  # GTK settings
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
	accent = "mauve";
      };
      name = "Papirus-Dark";
    };
  };

  # QT settings
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Home packages
  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka

    # GUI
    brave

    # Utils
    ripgrep
    fzf
    eza
    jq
    zip
    unzip
    tree
  ];
  fonts.fontconfig.enable = true; # For the system to see fonts from home.packages

  # Creating user directiores (~/Downloads, ~/Pictures, etc.)
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  home.stateVersion = "25.11";
}
