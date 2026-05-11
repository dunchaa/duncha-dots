{ config, pkgs, ... }:

let
  wallImg = ../../config/wallpapers/sakura-gate.jpg;
  colors = config.lib.catppuccin.getColors config.catppuccin;
in
{
  programs.hyprlock = {
    enable = true;
    
    settings = {
      general = {
        disable_loading = true;
	grace = 0;
	hide_cursor = true;
      };

      background = [
        {
	  path = "${wallImg}";
	  blur_passes = 3;
	  color = "rgb(${colors.base.rgb})";
	}
      ];

      input-field = [
        {
	  size = "200, 50";
	  outline_thickness = 3;
	  dots_size = 0.33;
	  dots_spacing = 0.15;
	  dots_center = true;

	  outer_color = "rgb(${colors.mauve.rgb})";
	  inner_color = "rgb(${colors.surface0.rgb})";
	  font_color = "rgb(${colors.text.rgb})";
	  
	  fade_on_empty = true;
	  placeholder_text = "<i>Password...<i>";
	  hide_input = false;
	  position = "0, -20";
	  halign = "center";
	  valign = "center";
	}
      ];

      label = [
        {
	  text = "$TIME";
	  color = "rgb(${colors.text.rgb})";
	  font_size = 64;
	  font_family = "JetBrainsMono Nerd Font Bold";
	  position = "0, 80";
	  halign = "center";
	  valign = "center";
	}
      ];
    };
  };
}
