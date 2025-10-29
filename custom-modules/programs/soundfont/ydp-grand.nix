{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont.ydp-grand; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.soundfont.ydp-grand = {
		enable = lib.mkEnableOption ''
			Whether to install the YDP-Grand MIDI soundfonts, an acoustic grand piano soundfont.
			CCA 3.0 license.
		'';

		package = lib.mkPackageOption pkgs "soundfont-ydp-grand" {};
	};

	config = lib.mkIf cfg.enable {
		environment = {
			systemPackages = [ cfg.package ];
			pathsToLink = [ "/share/soundfonts" ];
		};
	};
}