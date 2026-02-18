{ config, lib, pkgs, ... }: let
	cfg = config.programs.midiplus-smartpad-rgb-editor;
	pkg = pkgs.callPackage ../packages/midiplus-smartpad-rgb-editor.nix {};
in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.midiplus-smartpad-rgb-editor.install = lib.mkEnableOption ''
		# Whether to install the MIDIPLUS SmartPad RGB Editor, an RGB editor for the MIDIPLUS SmartPad, and some other 8×8 MIDI pads.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkg;
}