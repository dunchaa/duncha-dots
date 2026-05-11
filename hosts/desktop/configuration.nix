{ config, pkgs, user, ... }:

{
  imports =
    [
      ./hardware-configuration.nix  # Copy /etc/nixos/hardware-configuration.nix
      ../../modules/core/boot.nix
      ../../modules/core/network_and_sound.nix
      ../../modules/desktop/hyprland.nix
    ];

  # Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable the Flakes feature
  nixpkgs.config.allowUnfree = true; # Allow proprietary packages
  nix.optimise.automatic = true; # Auto delete duplicates in /nix/store

  # Locale
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # User
  users.users.${user} = {
    isNormalUser = true;
    description = "Main";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Garbage Collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # System version
  system.stateVersion = "25.11";
}
