{ config, lib, ... }: lib.mkIf config.programs.niri.enable {
	home-manager.users.${config.userName}.programs.swaylock = rec {
		# Whether to enable Swaylock, a screen locking program for most Wayland compositors.
		enable = true;

		settings = {
			# Whether to ignore empty passwords and not validate them.
			ignore-empty-password = true;

			# Background image to display.
			image = "${config.home-manager.users.${config.userName}.home.homeDirectory}/.config/hypr/lockscreenimage.jpg";

			# Whether to show a caps lock indicator.
			indicator-caps-lock = true;

			# Scaling mode of the background image.
			# `stretch`, `fill`, `fit`, `center`, `tile`.
			scaling = "fill";

			# Whether to show the numbers of failed unlocking attempts.
			show-failed-attemps = true;

			# Whether to show the keyboard layout.
			show-keyboard-layout = true;
		};
	};
}