{ config, lib, pkgs, ... }: let cfg = config.programs.midiplus-smartpad-rgb-editor; in {
	options.programs.midiplus-smartpad-rgb-editor.enable = lib.mkEnableOption "an RGB editor for the MIDIPLUS SmartPad and some other 8×8 MIDI pads.";

	config.environment.systemPackages = lib.optional cfg.enable pkgs.midiplus-smartpad-rgb-editor;
}