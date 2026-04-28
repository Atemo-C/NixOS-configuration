{ config, lib, ... }: lib.mkMerge [
	{programs.niri = {
		enable = true;
		linkConfiguration = true;
	};}

	(lib.mkIf config.programs.niri.enable { programs = {
		noctalia-shell = {
			enable = true;
			linkConfiguration = true;
		};

		niri-screenshot.enable = true;
		fish.shellAbbrs.n = "niri-session";
	}; })
]