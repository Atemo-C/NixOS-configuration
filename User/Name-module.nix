# Module to define the user name & title throughout the configuration.
{ config, lib, ... }: { options = {

	userName = lib.mkOption { type = lib.types.str; };
	userTitle = lib.mkOption { type = lib.types.str; };

}; }
