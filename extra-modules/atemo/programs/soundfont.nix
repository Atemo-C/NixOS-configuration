{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.soundfont = {
		arachno.enable = lib.mkEnableOption ''
			Whether to enable the arachno MIDI soundfont, a genreal MIDI-compliant bank, aimed at enhancing the realism of your MIDI files and arrangements.
		'';

		fluid.enable = lib.mkEnableOption ''
			Whether to enable the fluid MIDI soundfont, Frank wen's pro-quality GM/GS soundfont
		'';

		generaluser.enable = lib.mkEnableOption ''
			Whether to enable the generaluser MIDI soundfont, a general MIDI SoundFont with a low memory footprint.
		'';

		ydp-grand.enable = lib.mkEnableOption ''
			Whether to enable the ydp-grand MIDI soundfont, an acoustic grand piano soundfont.
		'';

		config.environment = {
			systemPackages = with pkgs; [
				(lib.mkIf cfg.arachno.enable soundfont-arachno)
				(lib.mkIf cfg.fluid.enable soundfont-fluid)
				(lib.mkIf cfg.generaluser.enable soundfont-generaluser)
				(lib.mkIf cfg.ydp-grand.enable soundfont-ydp-grand)
			];

			pathsToLink = lib.optional
			(cfg.arachno.enable || cfg.fluid.enable || cfg.generaluser.enable || cfg.ydp-grand.enable)
			"/share/soundfonts";
		};
	};
}