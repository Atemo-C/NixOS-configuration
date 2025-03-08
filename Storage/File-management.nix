{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Alternative to the find command.
		fd

		# Alternative to the ls command.
		lsd

		# Move files to the trash. Alternative to rm and trash-cli.
		trashy
	];

	programs = {
		thunar = {
			# Whether to enable Thunar, the Xfce file manager.
			enable = true;

			# List of Thunar plugins to install.
			plugins = with pkgs.xfce; [
				# Thunar plugin providing file context menus for archives.
				thunar-archive-plugin

				# Thunar extension for automatic management of removable drives and media.
				thunar-volman

				# Thunar plugin providing tagging and renaming features for media files.
				thunar-media-tags-plugin
			];
		};

		# Whether to enable Xfconf, the Xfce configuration storage system.
		xfconf.enable = true;
	};

}
