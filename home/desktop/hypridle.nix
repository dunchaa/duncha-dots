{ config, pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
	after_sleep_cmd = "hyprctl dispatch dpms on";
	lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        # Lock screen in 5 min
	{
	  timeout = 300;
	  on-timeout = "loginctl lock-session";
	}

	# Disable monitor in 10 min
	{
	  timeout = 600;
	  on-timeout = "hyprctl dispatch dpms off";
	  on-resume = "hyprctl dispatch dpms on";
	}
      ];
    };
  };
}
