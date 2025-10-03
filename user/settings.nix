{ config, ... }: {
	users.users.${config.userName} = {
		# Short description (title) of the user account, typically the user's full name.
		description = "${config.userTitle}";

		# Extra groups to add the user to.
		extraGroups = [ "disk" "input" "plugdev" "render" "storage" "video" "wheel" ];

		# Set the user as a normal user.
		isNormalUser = true;
	};

	home-manager.users.${config.userName}.usersDirs = {
		# Whether to manage `$XDG_CONFIG_HOME/user-dirs.dirs`.
		enable = true;

		# Whether to enable automatic creation of the XDG user directories.
		createDirectories = true;

		# Directories to configure.
		desktop     = "${config.home.homeDirectory}/Other/Desktop";
		documents   = "${config.home.homeDirectory}/Documents";
		download    = "${config.home.homeDirectory}/Downloads";
		music       = "${config.home.homeDirectory}/Audio/Music";
		pictures    = "${config.home.homeDirectory}/Images";
		publicShare = "${config.home.homeDirectory}/Other/Public";
		templates   = "${config.home.homeDirectory}/Other/Templates";
		videos      = "${config.home.homeDirectory}/Videos";
	};
}