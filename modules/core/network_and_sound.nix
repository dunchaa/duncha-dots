{ config, pkgs, ... }:

{
  # NetworkManager
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Device name in local network

  # PipeWire
  services.pulseaudio.enable = false; # renamed from hardware.pulseaudio in 24.11
  security.rtkit.enable = true; # Realtime priority for sound
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Power on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true; # GUI app for bluetooth
}
