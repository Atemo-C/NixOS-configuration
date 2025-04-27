{ config, pkgs, ... }: {

	environment.systemPackages = [
		# Alternative to the find command.
		pkgs.fd

		# Alternative to the ls command.
		pkgs.lsd

		# Move files to the trash. Alternative to rm and trash-cli.
		pkgs.trashy
	];

	programs = rec {
		thunar = {
			# Enable Thunar, the Xfce file manager.
			enable = true;

			# List of Thunar plugins to install.
			plugins = [
				# Thunar plugin providing file context menus for archives.
				pkgs.xfce.thunar-archive-plugin

				# Thunar extension for automatic management of removable drives and media.
				pkgs.xfce.thunar-volman

				# Thunar plugin providing tagging and renaming features for media files.
				pkgs.xfce.thunar-media-tags-plugin
			];
		};

		# If Thunar is enabled, enable Xfconf, the Xfce configuration storage system.
		xfconf.enable = thunar.enable;
	};

}
