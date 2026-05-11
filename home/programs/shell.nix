{ config, pkgs, ... }:

{
  # fish — env через системный programs.fish.enable (vendor_conf.d).
  # POSIX-source nix-daemon руками не нужен, NixOS делает это сам.
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';

    # Aliases
    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      
      # Utils
      ls = "eza --icons --group-directories-first";
      ll = "eza -al --icons --group-directories-first";
      tree = "eza --tree --icons";
      cat = "bat";
      nv = "nvim";
    };
  };

  # Starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    
    # Settings
    settings = {
      add_newline = false;
      
      # Format
      format = "$directory$git_branch$git_status$character";
      right_format = "$cmd_duration";
      
      # Module settings
      directory = {
        style = "blue";
        read_only = " 󰌾";
        truncation_length = 4;
        truncate_to_repo = false;
      };
      
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      
      git_branch = {
        symbol = " ";
        style = "purple";
      };
    };
  };

  # Zoxide (Smart cd)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Bat (beautiful cat)
  programs.bat = {
    enable = true;
  };
}
