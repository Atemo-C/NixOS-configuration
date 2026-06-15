{ config, lib, pkgs, ... }: let cfg = config.programs.noctalia-shell; in {
	options.programs.noctalia-shell.enable = lib.mkEnableOption
		"the Noctalia Shell, a beautiful, minimal desktop shell for Wayland that actually gets out of your way.";

	config.environment.systemPackages = lib.optionals cfg.enable (with pkgs; [
		noctalia-shell
		cliphist
		wl-clipboard
	]);
}