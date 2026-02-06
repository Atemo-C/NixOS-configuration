{ config, lib, pkgs, ... }: let cfg = config.programs.android-tools; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.android-tools.install = lib.mkEnableOption ''
		Whether to install android-tools, the Android SDK platform tools.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.android-tools;
}