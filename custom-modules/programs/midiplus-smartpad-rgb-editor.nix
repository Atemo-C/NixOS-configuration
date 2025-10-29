{ config, lib, pkgs, ... }: let
	cfg = config.programs.scrcpy;
	midiplus-smartpad-rgb-editor = pkgs.callPackage ../package/midiplus-smartpad-rgb-editor.nix {};
in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.midiplus-smartpad-rgb-editor = {
		enable = lib.mkEnableOption ''
			Whether to install the MIDIPLUS Smartpat RGB Editor, an RGB editor for the MIDIPLUS SmartPad and some other 8×8 MiDi pads.
		'';

		package = lib.mkPackageOption pkgs "midiplus-smartpad-rgb-editor" {};
	};

	config.environment.systemPackages = lib.optional cfg.enable cfg.package;
}