{ config, lib, ... }: let

	# Define the list of colors shared across terminals.
	Background    = "000000"; Foreground    = "eeeeee";

	normalBlack   = "161616";    dimBlack   = "060606";    brightBlack   = "333333";
	normalBlue    = "0080ff";    dimBlue    = "005ab3";    brightBlue    = "66b3ff";
	normalCyan    = "00ffff";    dimCyan    = "00b3b3";    brightCyan    = "66ffff";
	normalGreen   = "00ff00";    dimGreen   = "00b300";    brightGreen   = "66ff66";
	normalMagenta = "ff0080";    dimMagenta = "b3005a";    brightMagenta = "ff66b3";
	normalRed     = "ff0000";    dimRed     = "b30000";    brightRed     = "ff6666";
	normalWhite   = "e6e6e6";    dimWhite   = "b3b3b3";    brightWhite   = "ffffff";
	normalYellow  = "ffc000";    dimYellow  = "b38600";    brightYellow  = "ffd966";

	# Alacritty check for Alacritty-specific theming.
	# Alacritty is toggleable in the `./Programs/Terminal-emulators.nix` module.
	alacritty = config.home-manager.users.${config.userName}.programs.alacritty.enable;

in {

	# Linux console (TTY) colors.
	console = {
		# The 16 colors palette used by the virtual consoles.
		colors = [
			Background
			normalRed
			normalGreen
			normalYellow
			normalBlue
			normalMagenta
			normalCyan
			normalWhite
			normalBlack
			brightRed
			brightGreen
			brightYellow
			brightBlue
			brightMagenta
			brightCyan
			brightWhite
		];

		# Enable setting virtual console options (such as colors) as early as possible (in initrd).
		earlySetup = true;
	};

	# Alacritty colors.
	home-manager.users.${config.userName}.programs.alacritty.settings.colors = lib.optionalAttrs alacritty {
		primary = {
			background = "#${Background}";
			foreground = "#${Foreground}";
		};
		dim = {
			black = "#${dimBlack}";
			blue = "#${dimBlue}";
			cyan = "#${dimCyan}";
			green = "#${dimGreen}";
			magenta = "#${dimMagenta}";
			red = "#${dimRed}";
			white = "#${dimWhite}";
			yellow = "#${dimYellow}";
		};
		normal = {
			black = "#${normalBlack}";
			blue = "#${normalBlue}";
			cyan = "#${normalCyan}";
			green = "#${normalGreen}";
			magenta = "#${normalMagenta}";
			red = "#${normalRed}";
			white = "#${normalWhite}";
			yellow = "#${normalYellow}";
		};
		bright = {
			black = "#${brightBlack}";
			blue = "#${brightBlue}";
			cyan = "#${brightCyan}";
			green = "#${brightGreen}";
			magenta = "#${brightMagenta}";
			red = "#${brightRed}";
			white = "#${brightWhite}";
			yellow = "#${brightYellow}";
		};
	};

}
