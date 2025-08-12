{ config, lib, ... }: let
	# Define the list of colors shared across terminals.
	Background    = "000000";    Foreground = "eeeeee";
	normalBlack   = "161616";    dimBlack   = "060606";    brightBlack   = "333333";
	normalBlue    = "0080ff";    dimBlue    = "005ab3";    brightBlue    = "66b3ff";
	normalCyan    = "00ffff";    dimCyan    = "00b3b3";    brightCyan    = "66ffff";
	normalGreen   = "00ff00";    dimGreen   = "00b300";    brightGreen   = "66ff66";
	normalMagenta = "ff0080";    dimMagenta = "b3005a";    brightMagenta = "ff66b3";
	normalRed     = "ff0000";    dimRed     = "b30000";    brightRed     = "ff6666";
	normalWhite   = "e6e6e6";    dimWhite   = "b3b3b3";    brightWhite   = "ffffff";
	normalYellow  = "ffc000";    dimYellow  = "b38600";    brightYellow  = "ffd966";

	# Shortcut to check if Foot is enabled.
	# Foot is toggleable in the `./programs/terminal-emulators.nix` module.
	foot = config.home-manager.users.${config.userName}.programs.foot.enable;

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

	# Colors of the Foot terminal emulator.
	home-manager.users.${config.userName}.programs.foot.settings.colors = lib.mkIf foot {
		# Foreground color (default text).
		foreground = Foreground;

		# Background color (its opacity is configured further down).
		background = Background;

		# Normal colors.
		regular0 = normalBlack;
		regular1 = normalRed;
		regular2 = normalGreen;
		regular3 = normalYellow;
		regular4 = normalBlue;
		regular5 = normalMagenta;
		regular6 = normalCyan;
		regular7 = normalWhite;

		# Bright colors.
		bright0 = brightBlack;
		bright1 = brightRed;
		bright2 = brightGreen;
		bright3 = brightYellow;
		bright4 = brightBlue;
		bright5 = brightMagenta;
		bright6 = brightCyan;
		bright7 = brightWhite;

		# Dim colors.
		dim0 = dimBlack;
		dim1 = dimRed;
		dim2 = dimGreen;
		dim3 = dimYellow;
		dim4 = dimBlue;
		dim5 = dimMagenta;
		dim6 = dimCyan;
		dim7 = dimWhite;
	};
}