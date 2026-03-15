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

		# Whether to enable dconf.
		dconf.enable = true;

		# Whether to install the Fuzzel menu.
		# Required by:
		# `/etc/nixos/scripts/cmd-polkit-fuzzel.sh`.
		# `/etc/nixos/scripts/screenshots/screenshot-selector.sh`.
		fuzzel.install = true;

		# Whether to install the Noctalia desktop shell.
		# Note: The following services are needed for a complete experience:
		# `networking.networkmanager.enable`
		# `hardware.bluetooth.enable`
		# `services.power-profiles-daemon.enable` OR `services.tuned.enable`
		# `services.upower.enable`
		noctalia-shell.install = true;

		# Whether to install Swayidle.
		swayidle.install = true;

		# Shell abbreviation to start Niri by typing `n`.
		fish.shellAbbrs.n = "niri-session";
	};

	# GSettings/dconf workaround for certain programs. Not ideal, but…yeah.
	# https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix
	# https://github.com/NixOS/nixpkgs/issues/149812
	environment = {
		extraInit = ''export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"'';
		variables.GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
	};

	# Link relevant configuration files.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.concatLists [
		# Niri's configuration directory.
		(lib.optional programs.niri.enable
		"L %h/.config/niri/ - - - - /etc/nixos/files/niri/")

		# Fuzzel's configuration file.
		(lib.optional programs.fuzzel.install
		"L %h/.config/fuzzel/fuzzel.ini - - - - /etc/nixos/files/fuzzel.ini")

		# Noctalia's configuration directory.
		(lib.optional programs.noctalia-shell.install
		"L %h/.config/noctalia/ - - - - /etc/nixos/files/noctalia/")
	];
}