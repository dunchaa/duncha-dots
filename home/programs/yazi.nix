{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      manager = {
        show_hidden = false;
	sort_by = "natural";
	sort_dir_first = true;
	sort_reverse = false;
	linemode = "size";
	show_symlink = true;
      };

      preview = {
        tab_size = 1;
	max_width = 1000;
	max_height = 1000;
	cache_dir = "~/.cache/yazi";
	image_filter = "triangle";
	image_quality = 75;
      };
    };
  };

  home.packages = with pkgs; [
    ffmpegthumbnailer # Video preview
    poppler           # PDF preview
    p7zip             # .zip, .7z
    unrar             # .rar
    fd                # Blazing fast searcher
    ripgrep           # Find text inside files
    imagemagick       # SVG preview
    wl-clipboard      # Wayland clipboard
    xdg-utils         # Open files in GUI apps
    trash-cli         # Trash
  ];
}
