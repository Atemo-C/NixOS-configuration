{ lib, ... }: { options.user = {
	name = lib.mkOption {
		type = lib.types.strMatching "^[a-zA-Z0-9-]{1,31}$";
		default = "user-name";
		description = "The name of the user account. [a-Z] [0-9] [-]";
	};

	title = lib.mkOption {
		type = lib.types.str;
		default = "Fancy user name";
		description = "The description (title, fancier name) of the user.";
	};
}; }