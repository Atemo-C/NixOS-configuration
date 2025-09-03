{ config, lib, pkgs, ... }: {
	environment = {
		# File management utilities to install.
		systemPackages = with pkgs; [
			fd     # Alternative to the `find` command.
			trashy # Alternative to `rm` and `trash-cli`.
		];

		# Set the default file manager.
		variables.FILEMANAGER = lib.mkIf config.programs.thunar.enable "thunar";
	};

	programs = rec {
		thunar = {
			# Whether to enable the Thunar file manager.
			enable = true;

			# List of Thunar plugins to install.
			plugins = with pkgs.xfce; [
				thunar-archive-plugin    # Plugin providing file context menus for achives.
				thunar-vcs-plugin        # Plugin providing support for Subversion and Git.
				#thunar-volman            # Plugin for automatic management of removable drives and media.
				thunar-media-tags-plugin # Plugin providing tagging and renaming features for media files.
			];
		};

		# Enable Xfconf for Thunar, the Xfce configuration storage system.
		xfconf.enable = thunar.enable;
	};

	# Whether to enable LSD, an alternative to the `ls` command.
	home-manager.users.${config.userName}.programs.lsd.enable = true;

	# Default size of the separator between icons and normal text.
	home-manager.users.${config.userName}.programs.lsd.settings.icons.separator = "  ";

	# Link configuration files.
	home-manager.users.${config.userName}.systemd.user.tmpfiles.rules = [
		# Mimeapps configuration.
		"L %h/.config/mimeapps.list - - - - /etc/nixos/storage/files/mimeaps.list"
	] ++ lib.optional config.programs.thunar.enable

		# Custom actions for the Thunar file manager.
		"L %h/.config/Thunar/uca.xml - - - - /etc/nixos/storage/files/thunar-custom-actions.xml";

	# Add `lsd` shell abbreviations.
	programs.fish.shellAbbrs = lib.mkIf (config.programs.fish.enable &&
	config.home-manager.users.${config.userName}.programs.lsd.enable) rec {
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
}