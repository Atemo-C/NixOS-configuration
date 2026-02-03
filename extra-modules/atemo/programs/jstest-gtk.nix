{ config, lib, pkgs, ... }: let cfg = config.programs.jstest-gtk; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.jstest-gtk.install = lib.mkEnableOption ''
		Whether to install jstest-gtk, a simple joystick tester based on Gtk+.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.jstest-gtk;
}