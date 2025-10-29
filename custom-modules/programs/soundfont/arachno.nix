{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont.arachno; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.soundfont.arachno = {
		enable = lib.mkEnableOption ''
			Whether to install the Arachno MIDI soundfonts, a general MIDI-compliant bank, aimed at enhancing the realism of your MIDI files and arrangements.
			Unfree license.
		'';

		package = lib.mkPackageOption pkgs "soundfont-arachno" {};
	};

	config = lib.mkIf cfg.enable {
		environment = {
			systemPackages = [ cfg.package ];
			pathsToLink = [ "/share/soundfonts" ];
		};
	};
}