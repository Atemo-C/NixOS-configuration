{ config, pkgs, ... }: {
	# Whether to enable the Niri Wayland compositor.
	# XWayland support is enabled by default. You can disable it with the following option:
	# programs.niri.xwaylandSupport = false;
	programs.niri.enable = true;

	# Link Niri's configuration directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/"
	];

	# Import modules that help create a more complete desktop experience.
	imports = [
		# Polkit authentification using Fuzzel as the menu and cmd-polkit as the backend.
		./fuzzel-cmd-polkit-agent.nix

		# Log in to Niri with a nice TUI interface.
		./ly.nix

		# Noctalia desktop shell, providing:
		# A bar, notifications, power/program menus, idle management, and more.
		./noctalia-shell.nix

		# Screenshot management for Niri.
		./screenshot.nix
	];

	# GSettings/dconf workaround for certain programs. Not ideal, but it works.
	# https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix
	# https://github.com/NixOS/nixpkgs/issues/149812
	environment = {
		extraInit = ''export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"'';
		variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
	};
}