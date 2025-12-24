{ config, lib, ... }: {
	programs.foot = {
		# Whether to install the Foot terminal emulator.
		enable = true;

		settings = {
			colors = {
				# Color scheme, handled in the `/etc/nixos/theming/terminalColors.nix` module.
				foreground = config.theming.terminalColors.foreground;
				background = config.theming.terminalColors.background;
				regular0 = config.theming.terminalColors.black;
				regular1 = config.theming.terminalColors.red;
				regular2 = config.theming.terminalColors.green;
				regular3 = config.theming.terminalColors.yellow;
				regular4 = config.theming.terminalColors.blue;
				regular5 = config.theming.terminalColors.magenta;
				regular6 = config.theming.terminalColors.cyan;
				regular7 = config.theming.terminalColors.white;
				bright0 = config.theming.terminalColors.brightBlack;
				bright1 = config.theming.terminalColors.brightRed;
				bright2 = config.theming.terminalColors.brightGreen;
				bright3 = config.theming.terminalColors.brightYellow;
				bright4 = config.theming.terminalColors.brightBlue;
				bright5 = config.theming.terminalColors.brightMagenta;
				bright6 = config.theming.terminalColors.brightCyan;
				bright7 = config.theming.terminalColors.brightWhite;
				dim0 = config.theming.terminalColors.dimBlack;
				dim1 = config.theming.terminalColors.dimRed;
				dim2 = config.theming.terminalColors.dimGreen;
				dim3 = config.theming.terminalColors.dimYellow;
				dim4 = config.theming.terminalColors.dimBlue;
				dim5 = config.theming.terminalColors.dimMagenta;
				dim6 = config.theming.terminalColors.dimCyan;
				dim7 = config.theming.terminalColors.dimWhite;

				# Opacity of the window background.
				alpha = "0.8";
			};

			# Use the default monospace font with a custom size.
			# Fonts are handled in the `/etc/nixos/theming/fonts.nix` module.
			main.font = "monospace:size=12";

			# Modified search key binding that feels more natural.
			key-bindings.search-start = "Control+Shift+f";

			# Number of lines to keep in memory.
			scrollbcak.lines = 10000;
		};
	};
}