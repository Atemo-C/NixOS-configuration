{ config, lib, pkgs, ... }: let
	nir = config.programs.niri.enable;
	noc = config.programs.noctalia-shell.enable;
	gdm = config.services.displayManager.gdm.enable;
in {
	imports = [
		# Noctalia shell program module.
		../extra-modules/programs/noctalia-shell.nix

		# Niri screenshot program module.
		../extra-modules/programs/niri-screenshot.nix
	];

	programs = {
		# Whether to enable the Niri Wayland compositor.
		niri.enable = true;

		# Screenshot script for Niri.
		niri-screenshot.enable = true;

		# Whether to enable the Noctalia desktop shell.
		noctalia-shell.enable = true;

		# Command shortcut to start Niri from the console.
		fish.shellAbbrs.n = lib.mkIf nir "niri-session";
	};

	# Optional XWayland support.
	environment.systemPackages = lib.optional nir pkgs.xwayland-satellite;

	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.concatLists [
		# Link Niri's configuration files to the user's home directory.
		(lib.optional nir "L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/")

		# Link Noctalia's configuration files to the user's home directory.
		(lib.optional noc "L %h/.config/noctalia/ - - - - /etc/nixos/desktop/files/noctalia/")
	];

	# Use the GNOME Display Manager. Seriously, it works great with Niri.
	services.displayManager = lib.mkIf nir {
		gdm = {
			# Whether to enable GDM.
			enable = false;

			# Whether to enable auto-suspend on GDM.
			autoSuspend = false;

			# Optional message to display on the login screen.
			banner = "Log in as ${config.user.name} on ${config.networking.hostName}";
		};

		# Set the default session to be Niri.
		# If starting Niri from the TTY instead, use the `niri-session` command manually.
		defaultSession = "niri";
	};
}