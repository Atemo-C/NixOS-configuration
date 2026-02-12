{ config, lib, pkgs, ... }: let cfg = config.programs.heimdall; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.heimdall.enable = lib.mkEnableOption ''
		Whether to enable heimdall, a cross-platfrom open-source tool suite used to flash firmware onto Samsung Galaxy devices.
	'';

	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			heimdall
			android-tools
		];

		users.users.${config.userName}.extraGroups = [ "adbusers" ];
	};
}