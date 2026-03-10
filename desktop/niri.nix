{ config, pkgs, ... }: {
	# Whether to enable the Niri Wayland compositor.
	# XWayland support is enabled by default. You can disable it with the following optiop:
	# programs.niri.xwaylandSupport = false;
	programs.niri.enable = true;

	# Link Niri's configuration directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/"
	];

	# Import modules that help create a more complete desktop experience.
	imports = [
		# Polkit authentification using Fuzzel as the menu and cmd-polkit as the backend.
		./fuzzel-polkit-agent.nix

		# Log in to Niri with a nice TUI interface.
		./ly.nix

		# Noctalia desktop shell, providing a bar, notifications, power/program menus, and more.
		./noctalia-shell.nix

		# Idle management for security and power saving.
		./swayidle.nix
	];

	# Set appropriate environment variables when using Niri.
	environment = {
		# GSettings/dconf workaround for certain programs. Not ideal, but it works.
		# https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix
		# https://github.com/NixOS/nixpkgs/issues/149812
		extraInit = ''export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"'';
		variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";

		variables = {
			# Set the current desktop name.
			XDG_CURRENT_DESKTOP = "niri";

			# GTK: Use Wayland if available.
			GDK_BACKEND = "wayland";

			# QT: Use Wayland if available.
			QT_QPA_PLATFORM = "wayland";

			# QT: Enable automatic scaling based on the monitor's pixel density.
			QT_AUTO_SCREEN_SCALE_FACTOR = "1";

			# QT: Disable window decorations on QT applications.
			QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

			# Run SDL2 applications on Wayland.
			SDL_VIDEODRIVER = "wayland";

			# Force Clutter applications to use the Wayland backend.
			CLUTTER_BACKEND = "wayland";

			# Fix certain Java programs running under xwayland-satellite.
			_JAVA_AWT_WM_NONPARENTING = "1";
		};
	};
}