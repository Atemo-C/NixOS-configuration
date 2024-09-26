# This is a custom module that allows one to set their user name and title in a single file that is then automatically applied to all files that use `config.custom.name` and `config.custom.title`.

{ config, lib, ... }: {

	config.custom = {
		# Name of the user. Cannot contain spaces, uppercase characters, special characters, etc.
		name = "name-here";

		# Title of the user. It can be as fancy desired.
		title = "Title here";
	};

	# Custom module used to define a user name and title in the entire system.
	options.custom = {
		name = lib.mkOption { type = lib.types.str; };
		title = lib.mkOption { type = lib.types.str; };
	};

}
