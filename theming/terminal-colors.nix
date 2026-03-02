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

	rgb_background = "0,0,0";    rgb_foreground = "238,238,238";

	rgb_red     = "230,0,0";      rgb_light_red     = "255,102,102";
	rgb_green   = "0,204,0";      rgb_light_green   = "128,255,128";
	rgb_yellow  = "255,192,0";    rgb_light_yellow  = "255,232,128";
	rgb_blue    = "0,108,255";    rgb_light_blue    = "102,179,255";
	rgb_magenta = "208,0,255";    rgb_light_magenta = "236,128,255";
	rgb_cyan    = "0,208,255";    rgb_light_cyan    = "102,227,255";
	rgb_white   = "230,230,230";  rgb_light_white   = "255,255,255";
	rgb_black   = "36,36,36";     rgb_light_black   = "82,82,82";
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
	programs.foot.settings.colors = {
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

	# Colors for the kmscon console.
	services.kmscon.extraConfig = ''
palette=custom
palette-black=${rgb_black}
palette-red=${rgb_red}
palette-green=${rgb_green}
palette-yellow=${rgb_yellow}
palette-blue=${rgb_blue}
palette-magenta=${rgb_magenta}
palette-cyan=${rgb_cyan}
palette-light-grey=${rgb_white}
palette-light-red=${rgb_light_red}
palette-light-green=${rgb_light_green}
palette-light-yellow=${rgb_light_yellow}
palette-light-blue=${rgb_light_blue}
palette-light-magenta=${rgb_light_magenta}
palette-light-cyan=${rgb_light_cyan}
palette-white=${rgb_light_white}
palette-foreground=${rgb_foreground}
palette-background=${rgb_background}
	'';
}