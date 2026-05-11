{ config, pkgs, ... }:

{
  #fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';

    # Fish POSIX compatability fix
    loginShellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      end
    '';
    plugins = [
      {
        name = "foreign-env";
	src = pkgs.fishPlugins.foreign-env.src;
      }
    ];

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
