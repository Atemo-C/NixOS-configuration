{ ... }: let
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
		# THe 16 colors palette used by the virtual consoles.
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
}