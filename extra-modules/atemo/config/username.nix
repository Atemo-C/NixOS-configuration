{ lib, ... }: { options = {
	# Define the `userName` option.
	userName = lib.mkOption {
		# Set the type of the module (string).
		type = lib.types.str;

		# The default name of the user account.
		# [a-z] [A-Z] [0-9] [ - _ ]
		default = "atemo";

		# Description of the module.
		description = "The name of the user account. [a-z] [A-Z] [0-9] [ - _ ]";
	};

	# Define the `userTitle` option.
	userTitle = lib.mkOption {
		# Set the type of the module (string).
		type = lib.types.str;

		# The default title of the user.
		default = "Atemo Cajaku";

		# Description of the module.
		description = "The description (title) of the user.";
	};
};}