{ lib, ... }: { options.user = {
	name = lib.mkOption {
		type = lib.types.str;
		default = "user-name";
		description = "The name of the user account. [a-Z] [0-9] [-_]";
	};

	description = lib.mkOption {
		type = lib.types.str;
		default = "My fancy username!"
		description = "The full user name or a short description of the user."
	};
}; }