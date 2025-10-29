{ config, lib, pkgs, ... }: let cfg = config.programs.soundfont.fluid; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.soundfont.fluid = {
		enable = lib.mkEnableOption ''
			Whether to install the Fluid MIDI soundfonts, Frank Wen's pro-quality GM/GS soundfont
			MIT license.
		'';

		package = lib.mkPackageOption pkgs "soundfont-fluid" {};
	};

	config = lib.mkIf cfg.enable {
		environment = {
			systemPackages = [ cfg.package ];
			pathsToLink = [ "/share/soundfonts" ];
		};
	};
}