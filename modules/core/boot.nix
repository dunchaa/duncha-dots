{ pkgs, config, ... }:

{
  # Boot settings
  boot.kernelPackages = pkgs.linuxPackages_zen; # Zen Kernel
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      device = "nodev"; # Always "nodev" for EFI
      efiSupport = true;
      configurationLimit = 10;
    };
  };

  # Style settings
  catppuccin.grub = {
    enable = true;
    flavor = "mocha";
  };

  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "boot.shell_on_fail"
  ];
}
