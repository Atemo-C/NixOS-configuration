{ ... }: {
	# Import the module to set the user's name and description.
	imports = [ /etc/nixos/extra-modules/atemo/name.nix ];

	# Name of the user.
	# [a-Z] [0-9] [-_]
	userName = "atemo";

	# Description/Title of the user.
	userTitle = "Atemo Cajaku";
}