{ ... }: let
	# Define the list of colors shared across terminals.
	background = "000000";    foreground = "eeeeee";

	red     = "e60000";   dim_red     = "990000";   light_red     = "ff6666";
	green   = "00cc00";   dim_green   = "008000";   light_green   = "80ff80";
	yellow  = "ffc000";   dim_yellow  = "b38600";   light_yellow  = "ffe880";
	blue    = "006cff";   dim_blue    = "004cb3";   light_blue    = "66b3ff";
	magenta = "d000ff";   dim_magenta = "a247b3";   light_magenta = "ec80ff";
	cyan    = "00d0ff";   dim_cyan    = "0092b3";   light_cyan    = "66e3ff";
	white   = "e6e6e6";   dim_white   = "999999";   light_white   = "ffffff";
	black   = "242424";   dim_black   = "141414";   light_black   = "525252";
in {
	console = {
		# The 16 colors palette used by the virtual consoles (TTY).
		colors = [
			background
			red
			green
			yellow
			blue
			magenta
			cyan
			white
			black
			light_red
			light_green
			light_yellow
			light_blue
			light_magenta
			light_cyan
			light_white
		];

		# Whether to enable setting virtual console options as early as possible (initrd).
		# This allows settings like colors and fonts to be applied immediately.
		earlySetup = true;
	};

	# Colors for the Foot terminal emulator.
	programs.foot.settings.colors-dark = {
		alpha = "0.8";

		foreground = foreground;
		background = background;

		regular0 = black;
		regular1 = red;
		regular2 = green;
		regular3 = yellow;
		regular4 = blue;
		regular5 = magenta;
		regular6 = cyan;
		regular7 = white;

		bright0 = light_black;
		bright1 = light_red;
		bright2 = light_green;
		bright3 = light_yellow;
		bright4 = light_blue;
		bright5 = light_magenta;
		bright6 = light_cyan;
		bright7 = light_white;

		dim0 = dim_black;
		dim1 = dim_red;
		dim2 = dim_green;
		dim3 = dim_yellow;
		dim4 = dim_blue;
		dim5 = dim_magenta;
		dim6 = dim_cyan;
		dim7 = dim_white;
	};
}