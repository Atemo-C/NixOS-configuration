{ config, lib, ... }: {

	options = {
		# Define the `userName` option.
		userName = lib.mkOption {
			# Set the type of the module (string).
			type = lib.types.str;

			# The default name of the user account.
			# [a-z] [A-Z] [0-9] [ - _ ]
			default = "stanley";

			# Description of the module.
			description = "The name of the user account. Can be overriden with `config.userName`.";
		};

		# Define the `userTitle` option.
		userTitle = lib.mkOption {
			# Set the type of the module (string).
			type = lib.types.str;

			# The default title of the user.
			default = "Stanley";

			# Description of the module.
			description = "The description (title) of the user. Can be overriden with `config.userTitle`.";
		};
	};

}
