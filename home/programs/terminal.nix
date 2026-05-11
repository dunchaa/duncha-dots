{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true; # Fish integration

    # Fonts
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    # Settings
    settings = {
      # Specific settings
      linux_display_server = "wayland";
      hide_window_decorations = "yes";
      
      # Cursor
      cursor_shape = "beam";
      mouse_hide_wait = "3.0";
      
      # Other
      window_padding_width = 10;
      enable_audio_bell = "no";
      sync_to_monitor = "yes";
      background_opacity = "0.85";
      scrollback_lines = 10000;
      update_check_interval = 0;
    };

    # Bindings
    keybindings = {
      "ctrl+c" = "copy_or_interrupt"; # If selected - copy, if not - kill process
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+f5" = "load_config_file"; # Fast config reload
    };
  };
}
