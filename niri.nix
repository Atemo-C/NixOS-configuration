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

		# Whether to install cmd-polkit for Polkit authentification used in dmenu-like menus.
		# Required by `/etc/nixos/scripts/cmd-polkit-fuzzel.sh`.
		cmd-polkit.install = true;

		# Whether to enable dconf.
		dconf.enable = true;

		# Whether to install the Fuzzel menu.
		# Required by:
		# `/etc/nixos/scripts/cmd-polkit-fuzzel.sh`.
		# `/etc/nixos/scripts/power/power-menu.sh`
		# `/etc/nixos/scripts/programs/program-launcher.sh`
		# `/etc/nixos/scripts/screenshots/screenshot-selector.sh`.
		fuzzel.install = true;

		# Whether to install the Noctalia desktop shell.
		# Note: The following services are needed for a complete experience:
		# `networking.networkmanager.enable`
		# `hardware.bluetooth.enable`
		# `services.power-profiles-daemon.enable` OR `services.tuned.enable`
		# `services.upower.enable`
		noctalia-shell.install = true;

		# Shell abbreviation to start Niri by typing `n`.
		fish.shellAbbrs.n = "niri-session";
	};

	# Link relevant configuration files.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.concatLists [
		# Niri's configuration file.
		(lib.optional programs.niri.enable
		"L %h/.config/niri/config.kdl - - - - /etc/nixos/files/niri.kdl")

		# Fuzzel's configuration file.
		(lib.optional programs.fuzzel.install
		"L %h/.config/fuzzel/fuzzel.ini - - - - /etc/nixos/files/fuzzel.ini")
	];
}