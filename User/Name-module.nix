# Module to define the user name & title throughout the configuration.
{ config, lib, ... }: { options.custom = {

	name = lib.mkOption { type = lib.types.str; };
	title = lib.mkOption { type = lib.types.str; };

}; }
