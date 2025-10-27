{ config, lib, pkgs, ... }: let cfg = config.programs.gnirehtet; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.gnirehtet = {
		enable = lib.mkEnableOption ''
			Whether to install gnirehtet, a tool for reverse tethering Android devices over ADB.
		'';

		package = lib.mkPackageOption pkgs "gnirehtet" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		programs.adb.enable = true;
		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}