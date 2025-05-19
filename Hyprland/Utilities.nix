{ config, lib, pkgs, ... }: let

	# Hyprland check for various utilities.
	# Hyprland is toggleable in the `./Hyprland/Enable.nix` module.
	hyprland = config.enableHyprland;

in {

	# Utilties for a more fully-featured Hyprland desktop.
	environment.systemPackages = lib.optionalAttrs hyprland [
		# Keyring.
		pkgs.gnome-keyring

		# Wallpaper utility.
		pkgs.hyprpaper

		# Legacy X11 tools for Xwaland programs.
		pkgs.xorg.xrandr

		# Display graphical dialogs for shell scripts.
		pkgs.zenity
	];

	home-manager.users.${config.userName} = lib.optionalAttrs hyprland {
		# Tofi menu for shell scripts.
		programs.tofi = {
			# Enable Tofi, a tiny dynamic menu for Wayland, if Hyprland is used.
			enable = true;

			# Settings to be written to the Tofi configuration file.
			settings = {
				# Window background color
				background-color = "#000000dd";

				# Selection text color.
				selection-color = "#ffffff";

				# Selection text background color.
				selection-background = "#0f415fdd";

				# Selection background padding.
				selection-background-padding = 6;

				# Input text background.
				input-background = "#141414dd";

				# Input background padding.
				input-background-padding = 6;

				# Padding between borders and text. Can be pixels or a percentage.
				padding-top = 4;
				padding-bottom = 4;
				padding-left = 4;
				padding-right = 4;

				# Spacing between results in pixels. Can be negative.
				result-spacing = 12;

				# Width of the border in pixels.
				border-width = 2;

				# Border color.
				border-color = "#0080ff";

				# Width of the border outlines in pixels.
				outline-width = 0;
			};
		};

		# Start relevant utilities when logging into Hyprland.
		wayland.windowManager.hyprland.settings.exec-once = [
			# Start the keyring.
			"gnome-keyring-daemon"

			# Start the wallpaper utility.
			"hyprpaper"
		];
	};

	# If Hyprland is enabled, enable Dconf.
	programs.dconf.enable = lib.optionalAttrs hyprland true;

	# XDG Desktop Portal settings.
	xdg.portal = lib.optionalAttrs hyprland {
		# List of packages that provide XDG Desktop Portal configuration.
		configPackages = [
			# Hyprland Desktop Portal.
			pkgs.xdg-desktop-portal-hyprland

			# GTK Desktop Portal.
			pkgs.xdg-desktop-portal-gtk
		];

		# Additional portals to add to the path.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

		# Enable XDG Desktop integration, a must on Wayland.
		enable = true;
	};

}

