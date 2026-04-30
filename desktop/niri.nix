{ config, lib, ... }: lib.mkMerge [
	{ programs.niri = {
		enable = true;
		linkConfiguration = true;
	}; }

	(lib.mkIf config.programs.niri.enable { programs = {
		fish.shellAbbrs.n = "niri-session";
		niri-screensot.enable = true;

		noctalia-shell = {
			enable = true;
			linkConfiguration = true;
		};
	}; })
]