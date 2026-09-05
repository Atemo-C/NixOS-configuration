{ config, lib, pkgs, ... }: let
	niri = config.programs.niri.enable;
	noc-s = config.programs.noctalia.enable;
	noc-g = config.services.displayManager.noctalia-greeter.enable;
in {
	programs = {
		# Whether to enable the Niri Wayland compositor.
		niri.enable = true;

		noctalia = {
			# Whether to enable the Noctalia desktop shell.
			enable = lib.mkIf niri true;

			# Whether to enable the services used by Noctalia's integrations.
			recommendedServices.enable = true;

			# Whether to enable a systemd user service for Noctalia.
			# This allows automatically starting it alongside the desktop session.
			systemd.enable = true;
		};
	};

	environment.systemPackages = lib.concatLists [
		# XWayland support.
		(lib.optional niri pkgs.xwayland-satellite)

		# Clipboard support.
		(lib.optional noc-s pkgs.wl-clipboard)
		(lib.optional noc-s pkgs.cliphist)
	];

	# Screenshot script for Niri.
	imports = [ ../extra-modules/scripts/niri-screenshot.nix ];

	services.displayManager.noctalia-greeter = {
		# Whether to enable the Noctalia Greeter.
		enable = true;

		# Apply the cursor theme defined in `/etc/nixos/theming/shared.nix`.
		cursorTheme = {
			name = "${config.cursor.name}";
			package = config.cursor.package;
		};

		# Apply the cursor size defined in `/etc/nixos/theming/shared.nix`.
		settings.cursor.size = config.cursor.size;
	};

	# Synchronization between the Noctalia Shell and the Noctalia Greeter.
	# https://docs.noctalia.dev/greeter/sync/?section=nixos#nixos
	security.polkit = lib.mkIf (noc-s && noc-g) {
		enable = true;
		enablePkexecWrapper = true;
		extraConfig = ''
			polkit.addRule(function(action, subject) {
				var allowedUsers = ["${config.user.name}"];

				if (action.id == "org.noctalia.greeter.sync-appearance" &&
						action.lookup("program") == "${pkgs.noctalia-greeter}/bin/noctalia-greeter-apply-appearance" &&
						action.lookup("user") == "root" &&
						subject.local && subject.active &&
						allowedUsers.indexOf(subject.user) >= 0) {
					return polkit.Result.YES;
				}
			});
		'';
	};

	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.concatLists [
		# Link Niri's configuration files to the user's home directory.
		(lib.optional niri "L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/")

		# Link Noctalia's main configuration file to the user's home directory.
		(lib.optional noc-s "L %h/.local/state/noctalia/settings.toml - - - - /etc/nixos/desktop/files/noctalia.toml")
	];
}