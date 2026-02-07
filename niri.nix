{ config, lib, ... }: rec {
	programs = {
		niri = {
			# Whether to install the Niri Wayland compositor.
			enable = true;

			# Whether to enable Xwayland support with xwayland-satellite.
			xwayland.enable = true;

			# Whether to enable Ozone Wayland support for Chromium and Electron-based programs.
			ozoneWayland.enable = true;
		};

		# Whether to install bemoji, an emoji picker for Linux that can be integrated into various scripts.
		bemoji.install = true;

		# Whether to install clipman. a simple clipboard manager for Wayland.
		clipman.install = lib.mkIf programs.niri.enable true;

		# Whether to enable dconf.
		dconf.enable = true;

		# Whether to install wl-clipboard. command-line copy/paste utilities for Wayland.
		wl-clipboard.install = lib.mkIf programs.niri.enable true;

		# Whether to install cmd-polkit for Polkit authentification used in dmenu-like menus.
		# Required by `/etc/nixos/scripts/cmd-polkit-fuzzel.sh`.
		cmd-polkit.install = lib.mkIf programs.niri.enable true;

		# Whether to install the Dunst notification daemon.
		# Required for most notifications.
		dunst.install = lib.mkIf programs.niri.enable true;

		# Whether to install the Fuzzel menu.
		# Required by:
		# `/etc/nixos/scripts/cmd-polkit-fuzzel.sh`.
		# `/etc/nixos/scripts/power/power-menu.sh`
		# `/etc/nixos/scripts/programs/program-launcher.sh`
		# `/etc/nixos/scripts/screenshots/screenshot-selector.sh`.
		fuzzel.install = lib.mkIf programs.niri.enable true;

		# Whether to install the Swaylock session locking utility.
		# Optional for `/etc/nixos/scripts/power/power-menu.sh`.
		swaylock.install = lib.mkIf programs.niri.enable true;

		# Whether to install the Waybar bar.
		waybar.enable = lib.mkIf programs.niri.enable true;

		# Whether to install the wbg wallpaper utility.
		# Required by `/etc/nixos/scripts/wallpaper/wallpaper-selector.sh`.
		# Currently, wbg is limited; But it is the lightest utility I found.
		wbg.install = lib.mkIf programs.niri.enable true;

		# Whether to install the zenity graphical dialogs utility for shell scripts.
		# Required by `/etc/nixos/scripts/wallpaper/wallpaper-selector.sh`.
		zenity.install = lib.mkIf programs.niri.enable true;

		# Shell abbreviation to start Niri by typing `n`.
		fish.shellAbbrs.n = lib.mkIf programs.niri.enable "niri-session";
	};

	# Link relevant configuration files.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.concatLists [
		# Niri's configuration file.
		(lib.optional programs.niri.enable
		"L %h/.config/niri/config.kdl - - - - /etc/nixos/files/niri.kdl")

		# Dunst's configuration file.
		(lib.optional programs.dunst.install
		"L %h/.config/dunst/dunstrc - - - - /etc/nixos/files/dunstrc.conf")

		# Fuzzel's configuration file.
		(lib.optional programs.fuzzel.install
		"L %h/.config/fuzzel/fuzzel.ini - - - - /etc/nixos/files/fuzzel.ini")

		# Swaylock's configuration file.
		(lib.optional programs.swaylock.install
		"L %h/.config/swaylock/config - - - - /etc/nixos/files/swaylock.conf")

		# Waybar's configuration files.
		(lib.optional programs.waybar.enable
		"L %h/.config/waybar/config - - - - /etc/nixos/files/waybar/config.json")
		(lib.optional programs.waybar.enable
		"L %h/.config/waybar/style.css - - - - /etc/nixos/files/waybar/style.css")
	];
}