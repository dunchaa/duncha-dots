{ config, pkgs, ... }:

{
  services.swaync = {
    enable = true;

    settings = {
      # Positions
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";

      # Popup design
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-2fa-action = true;
      notification-inline-replies = false;

      # Sizes and Timeouts
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;

      # Panel size
      fit-to-screen = false;
      control-center-width = 500;
      control-center-height = 600;

      # Widgets
      widgets = [
        "label"
	"mpris"
	"title"
	"dnd"
	"notifications"
      ];

      widget-config = {
        title = {
	  text = "Notifications";
	  clear-all-button = true;
	  button-text = "Clear All";
	};
	dnd = {
	  text = "Do Not Disturb";
	};
	label = {
	  max-lines = 1;
	  text = "Notification Center";
	};
	mpris = {
	  image-size = 96;
	  image-radius = 12;
	};
      };
    };
  };

  home.packages = with pkgs; [
    libnotify # Notifier
    playerctl # For player button in SwayNC
  ];
}
