{ config, lib, pkgs, ... }: let cfg = config.programs.tor-browser; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.tor-browser.install = lib.mkEnableOption ''
		Whether to install the Tor browser, a privacy-focused browser routing traffic through the Tor network.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.tor-browser;
}