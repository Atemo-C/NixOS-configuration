{ config, ... }: {
	# Import the module to set the user's name and title globally.
	imports = [ ../extra-modules/config/username.nix ];

	user = {
		# The username of the user. [a-Z] [0-9] [-]
		name = "atemo";

		# Description/Title of the user.
		title = "Atemo Cajaku";
	};

	users.users.${config.user.name} = {
		# Extra groups to add the user to.
		extraGroups = [
			"disk"
			"input"
			"plugdev"
			"render"
			"storage"
			"video"
			"wheel"
		];

		# Whether the user should be considered a normal user.
		isNormalUser = true;
	};
}