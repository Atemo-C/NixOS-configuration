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

		# Manually updated the Noctalia Greeter to 1.7.0.
		# https://github.com/NixOS/nixpkgs/pull/575952
		package = pkgs.noctalia-greeter.overrideAttrs (old: {
			version = "1.7.0";
			src = pkgs.fetchFromGitHub {
				owner = "noctalia-dev";
				repo = "noctalia-greeter";
				tag = "v1.7.0";
				hash = "sha256-ILFIjvpGFxwt6y9GDESlNcVm2t0Q2Ku108vWiqCsWfM=";
			};

			buildInputs = old.buildInputs ++ [ pkgs.libjxl ];
		});

		# Passwordless synching between the Noctalia shell Greeter.
		passwordlessSyncUsers = [ "${config.user.name}" ];

		# Apply the cursor size defined in `/etc/nixos/theming/shared.nix`.
		settings.cursor.size = config.cursor.size;
	};

	systemd.user.tmpfiles.users.${config.user.name}.rules = lib.concatLists [
		# Link Niri's configuration files to the user's home directory.
		(lib.optional niri "L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/")

		# Link Noctalia's main configuration file to the user's home directory.
		(lib.optional noc-s "L %h/.local/state/noctalia/settings.toml - - - - /etc/nixos/desktop/files/noctalia.toml")
	];
}