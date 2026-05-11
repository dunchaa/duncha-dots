{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    aylur-ags

    # Dependencies
    bun
    dart-sass
    fd
    brightnessctl
    swww
    matugen
    slurp
  ];

  # Symlink
  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink "/home/${user}/.dotfiles/config/ags";
}
