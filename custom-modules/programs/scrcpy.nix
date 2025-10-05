{ config, lib, pkgs, ... }: let cfg = config.programs.scrcpy; in {
	options.programs.scrcpy = {
		enable = lib.mkEnableOption "Display and control Android devices over USB or TCP/IP";
		package = lib.mkPackageOption pkgs "scrcpy" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		programs.adb.enable = true;
		users.users.${config.userName}.extraGroups = "adbusers";
	};
}