{ ... }: {
	# Import the module to set the user's name and description.
	imports = [ ../extra-modules/atemo/config/username.nix ];

	# Name of the user.
	# [a-Z] [0-9] [-_]
	userName = "atemo";

	# Description/Title of the user.
	userTitle = "Atemo Cajaku";
}