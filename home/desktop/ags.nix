{ config, pkgs, user, inputs, ... }:

{
  home.packages = with pkgs; [
    ags

    # Dependencies
    bun
    dart-sass
    fd
    swww
    matugen
    slurp
  ];

  # Symlink — путь берётся из home.homeDirectory, без хардкода /home/${user}
  xdg.configFile."ags".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/ags";
}
