{ config, lib, pkgs, ... }: let cfg = config.programs.speedtest; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.speedtest.install = lib.mkEnableOption ''
		Whether to install Speedtest, a graphical librespeed client written using GTK4 + libadwaita.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.speedtest;
}