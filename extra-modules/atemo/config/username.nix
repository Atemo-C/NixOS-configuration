{ lib, ... }: { options = {
	userName = lib.mkOption {
		type = lib.types.str;
		default = "user-name";
		description = "The name of the user account. [a-Z] [0-9] [-_]";
	};

	userTitle = lib.mkOption {
		type = lib.types.str;
		default = "Fancy user name";
		description = "The description (title, fancier name) of the user.";
	};
}; }