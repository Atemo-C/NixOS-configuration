{ config, lib, pkgs, ... }: let cfg = config.programs.bemoji; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.bemoji.install = lib.mkEnableOption ''
		Whether to enable bemoji, an emoji picker with support for bemenu/wofi/rofi/dmenu and wayland/X11.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.bemoji;
}