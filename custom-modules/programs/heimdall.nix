{ config, lib, pkgs, ... }: let cfg = config.programs.heimdall; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.heimdall = {
		enable = lib.mkEnableOption ''
			Whether to install heimdall, a tool suite used to flash firmware onto Samsung Galaxy devices.
		'';

		package = lib.mkPackageOption pkgs "heimdall" {
			default = [ "heimdall" ];
			example = [ "heimdall-gui" ];
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
		programs.adb.enable = true;
		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}