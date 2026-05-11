{ config, pkgs, ... }:

{
  # Enabling WM on system level
  programs.hyprland.enable = true;

  # XDG Portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = [ "hyprland" "gtk" ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Polkit Agent
  programs.dconf.enable = true;
  security.polkit.enable = true;

  # KDE Plasma 5 EOL → используем KF6/Qt6 вариант из kdePackages.
  environment.systemPackages = [
    pkgs.kdePackages.polkit-kde-agent-1
    pkgs.wl-clipboard
  ];

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Hardware acceleration (renamed from hardware.opengl in 24.11)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Display manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Security (Gnome Keyring)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
}
