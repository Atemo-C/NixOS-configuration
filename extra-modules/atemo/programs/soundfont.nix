{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.soundfont = {
		arachno.install = lib.mkEnableOption ''
			Whether to install the arachno MIDI soundfont, a genreal MIDI-compliant bank, aimed at enhancing the realism of your MIDI files and arrangements.
		'';

		fluid.install = lib.mkEnableOption ''
			Whether to install the fluid MIDI soundfont, Frank wen's pro-quality GM/GS soundfont
		'';

		generaluser.install = lib.mkEnableOption ''
			Whether to install the generaluser MIDI soundfont, a general MIDI SoundFont with a low memory footprint.
		'';

		ydp-grand.install = lib.mkEnableOption ''
			Whether to install the ydp-grand MIDI soundfont, an acoustic grand piano soundfont.
		'';

		config.environment = {
			systemPackages = with pkgs; [
				(lib.mkIf cfg.arachno.install soundfont-arachno)
				(lib.mkIf cfg.fluid.install soundfont-fluid)
				(lib.mkIf cfg.generaluser.install soundfont-generaluser)
				(lib.mkIf cfg.ydp-grand.install soundfont-ydp-grand)
			];

			pathsToLink = lib.optional
			(cfg.arachno.install || cfg.fluid.install || cfg.generaluser.install || cfg.ydp-grand.install)
			"/share/soundfonts";
		};
	};
}