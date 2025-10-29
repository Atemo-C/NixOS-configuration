{ config, lib, pkgs, ... }: let cfg = config.programs.alsa-utils; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.alsa-utils = {
		enable = lib.mkEnableOption ''
			Whether to install the ALSA utilities. For the list of utilities provided, see the link below:
			https://search.nixos.org/packages?channel=unstable&show=alsa-utils&query=alsa-utils
		'';

		package = lib.mkPackageOption pkgs "alsa-utils" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}