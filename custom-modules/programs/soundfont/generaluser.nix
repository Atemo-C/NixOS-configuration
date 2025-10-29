{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont.generaluser; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.soundfont.generaluser = {
		enable = lib.mkEnableOption ''
			Whether to install the Generaluser MIDI soundfonts, a general MIDI SoundFont with a low memory footprint.
			GS 2.0 license.
		'';

		package = lib.mkPackageOption pkgs "soundfont-generaluser" {};
	};

	config = lib.mkIf cfg.enable {
		environment = {
			systemPackages = [ cfg.package ];
			pathsToLink = [ "/share/soundfonts" ];
		};
	};
}