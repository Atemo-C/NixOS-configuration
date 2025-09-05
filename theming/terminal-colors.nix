{ config, lib, ... }: let
	# Define the list of colors shared across terminals.
	Background    = "000000";    Foreground = "eeeeee";
	normalBlack   = "242424";    dimBlack   = "141414";    brightBlack   = "525252";
	normalBlue    = "006cff";    dimBlue    = "004cb3";    brightBlue    = "66b3ff";
	normalCyan    = "00d0ff";    dimCyan    = "0092b3";    brightCyan    = "66e3ff";
	normalGreen   = "00cc00";    dimGreen   = "008000";    brightGreen   = "80ff80";
	normalMagenta = "d000ff";    dimMagenta = "a247b3";    brightMagenta = "ec80ff";
	normalRed     = "e60000";    dimRed     = "990000";    brightRed     = "ff6666";
	normalWhite   = "e6e6e6";    dimWhite   = "999999";    brightWhite   = "ffffff";
	normalYellow  = "ffc000";    dimYellow  = "b38600";    brightYellow  = "ffe880";
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
	home-manager.users.${config.userName}.programs.foot.settings.colors = {
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