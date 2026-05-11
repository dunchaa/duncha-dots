{ config, pkgs, ... }:

let
  wallImg = ../../config/wallpapers/sakura-gate.jpg;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "${wallImg}" ];
      wallpaper = [ ",${wallImg}" ];
    };
  };
}
