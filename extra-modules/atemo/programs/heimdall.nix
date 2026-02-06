{ config, lib, pkgs, ... }: let cfg = config.programs.heimdall; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.heimdall.enable = lib.mkEnableOption ''
		Whether to enable heimdall, a cross-platfrom open-source tool suite used to flash firmware onto Samsung Galaxy devices.
	'';

	config.environment.systemPackages = lib.optionals cfg.enable (with pkgs; [
		heimdall
		android-tools
	]);
}