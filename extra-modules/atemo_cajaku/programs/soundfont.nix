{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont; in {
	options.programs.soundfont = {
		arachno.enable = lib.mkEnableOption "the Arachno soundfont, a general MIDI-compliant bank, aimed at enhancing the realism of your MIDI files and arrangements.";
		fluid.enable = lib.mkEnableOption "Frank Wen's pro-quality GM/GS soundfont.";
		generaluser-gs.enable = lib.mkEnableOption "the generaluser-gs soundfont, a general MIDI soundfont with a low memory footprint.";
		ydp-grand.enable = lib.mkEnableOption "the ydp-grand soundfont, an acoustic grand piano soundfont.";
	};

	config.environment = {
		systemPackages = lib.concatLists (with pkgs; [
			(lib.optional cfg.arachno.enable soundfont-arachno)
			(lib.optional cfg.fluid.enable soundfont-fluid)
			(lib.optional cfg.generaluser-gs.enable soundfont-generaluser-gs)
			(lib.optional cfg.ydp-grand.enable soundfont-ydp-grand)
		]);

		pathsToLink = lib.optional
		(cfg.arachno.enable || cfg.fluid.enable || cfg.generaluser-gs.enable || cfg.ydp-grand.enable)
		"/share/soundfonts";
	};
}