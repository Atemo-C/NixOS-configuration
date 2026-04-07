{ config, lib, pkgs, ... }: let cfg = config.programs.jstest-gtk; in {
	options.programs.jstest-gtk.enable = lib.mkEnableOption "jstest-gtk, a simple joystick tester based on Gtk+";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.jstest-gtk;
}