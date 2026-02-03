{ config, lib, pkgs, ... }: let cfg = config.programs.xclicker; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.xclicker.install = lib.mkEnableOption ''
		Whether to install Xclicker, a fast GUI autoclicker for X11 and Xwayland Linux environments.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.xclicker;
}