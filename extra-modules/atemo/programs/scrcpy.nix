{ config, lib, pkgs, ... }: let cfg = config.programs.scrcpy; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.scrcpy.enable = lib.mkEnableOption ''
		Whether to enable scrcpy, a utility to display and control Android devices over USB or TCP/IP.
	'';

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			scrcpy
			android-tools
		];

		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}