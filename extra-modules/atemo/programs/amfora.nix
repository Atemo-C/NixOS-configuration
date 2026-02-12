{ config, lib, pkgs, ... }: let cfg = config.programs.amfora; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.amfora.install = lib.mkEnableOption ''
		Whether to install Amfora, a fancy terminal browser for the Gemini protocol.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.amfora;
}