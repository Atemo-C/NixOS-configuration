{ config, lib, pkgs, ... }: { programs = rec {
	niri = {
		# Install the Niri Wayland compositor.
		enable = true;

		# [C] Enable support for XWayland with the XWayland Satellite.
		xwayland.enable = true;

		# [C] Link Niri's configuration directory,
		# from `/etc/nixos/desktop/files/niri/` to `~/.config/niri/`.
		linkConfiguration = true;

		# [C] Apply workarounds to gsettings schemas sourcing and configuration.
		# https://github.com/NixOS/nixpkgs/issues/149812
		# https://github.com/thomX75/nixos-modules/blob/main/Glib-Schemas-Fix/glib-schemas-fix.nix
		gsettingsWorkarounds.enable = true;
	};

	ly = lib.mkIf niri.enable {
		# Install the ly display manager.
		enable = true;

		# Disable support for X11 environments.
		x11Support = false;
	};

	noctalia-shell = lib.mkIf niri.enable {
		# [C] Install the Noctalia Shell.
		enable = true;

		# [C] Link Noctalia's configuration directory,
		# from `/etc/nixos/desktop/files/noctalia/` to `~/.config/noctalia/`.
		linkConfiguration = true;
	};

	# [C] Install a screenshot utility for Niri.
	niri-screenshot.enable = lib.mkIf niri.enable true;
}; }