{ config, lib, pkgs, ... }: let cfg = config.programs.gnirehtet; in {
	options.programs.gnirehtet = {
		enable = lib.mkEnableOption "Reverse tethering over adb for Android";
		package = lib.mkPackageOption pkgs "gnirehtet" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		programs.adb.enable = true;
		users.users.${config.userName}.extraGroups = "adbusers";
	};
}