{ config, lib, pkgs, ... }: let
	cfg = config.programs.midiplus-smartpad-rgb-editor;
	midiplus-smpartpad-rbg-editor = pkgs.callPackage /etc/nixos/extra-modules/atemo/packages/midiplus-smartpad-rgb-editor.nix {};
in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.midiplus-smartpad-rgb-editor.install = lib.mkEnableOption ''
		Whether to install the MIDIPLUS Smartpad RGB Editor, an RGB editor for the MIDIPLUS SmartPad, and some other 8×8 MIDI pads.
	'';

	config.environment.systemPackages = lib.optional cfg.install pkgs.midiplus-smartpad-rgb-editor;
}