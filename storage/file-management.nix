{ config, lib, pkgs, ... }: rec {
	programs = {
		# Next generation ls command.
		lsd.install = true;

		thunar = {
			# Whether to enable the Thunar file manager.
			enable = true;

			# List of Thunar plugins to install.
			plugins = with pkgs; [
				# Plugin providing file context menus for archives.
				thunar-archive-plugin

				# Plugin providing support for Subversion and Git.
				thunar-vcs-plugin

				# Extension for automatic management of removable drive and media.
				thunar-volman

				# Plugin providing tagging and renaming features for media files.
				thunar-media-tags-plugin
			];
		};

		# Whether to enable Xfconf, the Xfce configuratioon system.
		# Thunar likes to have it around.
		xfconf.enable = lib.mkIf programs.thunar.enable true;

		# Shell abbreviations for `lsd`.
		fish.shellAbbrs = lib.mkIf programs.lsd.install rec {
			# List.
			l = "lsd --group-dirs first";
			list = l;

			# List all.
			la = "lsd --group-dirs first -A";
			list-all = la;

			# List long.
			ll = "lsd --group-dirs first -l";
			list-long = ll;

			# List tree.
			lt = "lsd --group-dirs first --tree";
			list-tree = lt;

			# List recursive.
			lr = "lsd --group-dirs first --recursive";
			list-recursive = lr;

			# List all+long.
			lal = "lsd --group-dirs first -Al";
			lla = lal;
			list-all-long = lal;
			list-long-all = lal;

			# List all+tree.
			lat = "lsd --group-dirs first -A --tree";
			lta = lat;
			list-all-tree = lat;
			list-tree-all = lat;

			# List all+recursive.
			lar = "lsd --group-dirs first -A --recursive";
			lra = lar;
			list-all-recursive = lar;
			list-recursive-all = lar;

			# List long+tree.
			llt = "lsd --group-dirs first -l --tree";
			ltl = llt;
			list-long-tree = llt;
			list-tree-long = llt;

			# List long+recursive.
			llr = "lsd --group-dirs first -l --recursive";
			lrl = llr;
			list-long-recursive = llr;
			list-recursive-long = llr;

			# List all+long+tree.
			lalt = "lsd --group-dirs first -Al --tree";
			latl = lalt;
			llta = lalt;
			llat = lalt;
			ltla = lalt;
			ltal = lalt;
			list-all-long-tree = lalt;
			list-all-tree-long = lalt;
			list-long-tree-all = lalt;
			list-long-all-tree = lalt;
			list-tree-long-all = lalt;
			list-tree-all-long = lalt;

			# List all+long+recursive.
			lalr = "lsd --group-dirs first -Al --recursive";
			larl = lalr;
			llra = lalr;
			llar = lalr;
			lrla = lalr;
			lral = lalr;
			list-all-long-recursive = lalr;
			list-all-recursive-long = lalr;
			list-long-recursive-all = lalr;
			list-long-all-recursive = lalr;
			list-recursive-long-all = lalr;
			list-recursive-all-long = lalr;
		};
	};

	# Link file management, Thunar, and other related files.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.concatLists [
		# Default programs to start when opening a file.
		[ "L %h/.config/mimeapps.list - - - - /etc/nixos/files/mimeapps.list" ]

		# LSD configuration file.
		(lib.optional programs.lsd.install
		"L %h/.config/lsd/config.yaml - - - - /etc/nixos/files/lsd.yaml")

		# Custom actions for Thunar.
		(lib.optional programs.thunar.enable
		"L %h/.config/Thunar/uca.xml - - - - /etc/nixos/files/thunar-custom-actions.xml")

		# XFCE4 helpers configuration file for Thunar.
		(lib.optional programs.thunar.enable
		"L %h/.config/xfce4/helpers.rc - - - - /etc/nixos/files/xfce4-helpers.rc")
	];
}