{ config, lib, pkgs, ... }: let cfg = config.programs.heimdall; in {
	options.programs.heimdall = {
		enable = lib.mkEnableOption "Cross-platform open-source tool suite used to flash firmware onto Samsung Galaxy devices";
		package = lib.mkPackageOption pkgs "heimdall" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		programs.adb.enable = true;
		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}