{ config, pkgs, ... }:

{
  # Enabling WM on system level
  programs.hyprland.enable = true;

  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Polkit Agent
  programs.dconf.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = [
    pkgs.polkit-kde-agent
    pkgs.wl-clipboard
  ];

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
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
