{ config, lib, pkgs, ... }: let cfg = config.programs.xfburn; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.xfburn.enable = lib.mkEnableOption ''
		Whether to install Xfburn, a disc burner and project creator for Xfce.
	'';

	config.environment.systemPackages = lib.optionals cfg.enable (with pkgs; [
		xfburn
		cdparanoia
		cdrdao
		cdrtools
		dvdplusrwtools
		vcdimager
	]);
}

