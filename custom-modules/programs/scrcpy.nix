{ config, lib, pkgs, ... }: let cfg = config.programs.scrcpy; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.scrcpy = {
		enable = lib.mkEnableOption ''
			Whether to install scrcpy, a utility to display and control Android devices over USB or TCP/IP.
		'';

		package = lib.mkPackageOption pkgs "scrcpy" {
			default = [ "scrcpy" ];
			example = [ "pkgs.qtscrcpy" ];
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package pkgs.android-tools ];
		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}
