# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Thunar
# • https://wiki.archlinux.org/title/Thunar
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=environment.variables
# • https://search.nixos.org/options?channel=24.05&show=programs.thunar.enable
# • https://search.nixos.org/options?channel=24.05&show=programs.thunar.plugins
# • https://search.nixos.org/options?channel=24.05&show=programs.xfconf.enable
#
# Used NixOS packages:
#─────────────────────
# • [fd]
#   https://github.com/sharkdp/fd
#
# • [lsd]
#   https://github.com/lsd-rs/lsd
#
# • [trashy]
#   https://github.com/oberblastmeister/trashy
#
# • [thunar-archive-plugin]
#   https://gitlab.xfce.org/thunar-plugins/thunar-archive-plugin
#
# • [thunar-volman]
#   https://gitlab.xfce.org/xfce/thunar-volman
#
# • [thunar-media-tags-plugin]
#   https://gitlab.xfce.org/thunar-plugins/thunar-media-tags-plugin

{ config, pkgs, ... }: {

	environment = {
		systemPackages = [
			# A simple, fast and user-friendly alternative to find.
			pkgs.fd

			# The next gen ls command.
			pkgs.lsd

			# A simple, fast, and featureful alternative to rm and trash-cli.
			pkgs.trashy
		];

		# Default file manager to use.
		variables = { FILEMANAGER = "thunar"; };
	};

	programs = {
		thunar = {
			# Whether to enable Thunar, the Xfce file manager.
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

		# Whether to enable Xfconf, the Xfce configuration storage system.
		xfconf.enable = true;
	};

}
