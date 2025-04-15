{ config, pkgs, ... }: {

	# Tool to display dialogs from the commandline and shell scripts.
	environment.systemPackages = [ pkgs.zenity ];

	# Tofi menu for various scripts.
	home-manager.users.${config.custom.name}.programs.tofi = {
		# Whether to enable Tofi, a tiny dynamic menu for Wayland.
		enable = true;

		# Settings to be written to the Tofi configuration file.
		settings = {
			# Font to use, either a path to a font file or a name.
			# If a CORRECT path is given, tofi will startup much quicker.
			# Otherwise, fonts are interpreted in Pango format.
#			font = "/run/current-system/sw/share/X11/fonts/UbuntuMonoNerdFont-Regular.ttf";

			# # Point size of text.
			font-size = 12;

			# Window background color
			background-color = "#000000dd";

			# Selection text color.
			selection-color = "#ffffff";

			# Selection text background color.
			selection-background = "#0f415fdd";

			# Selection background padding.
			selection-background-padding = 6;

			# Input text background.
			input-background = "#141414dd";

			# Input background padding.
			input-background-padding = 6;

			# Padding between borders and text. Can be pixels or a percentage.
			padding-top = 4;
			padding-bottom = 4;
			padding-left = 4;
			padding-right = 4;

			# Spacing between results in pixels. Can be negative.
			result-spacing = 12;

			# Width of the border in pixels.
			border-width = 2;

			# Border color.
			border-color = "#0080ff";

			# Width of the border outlines in pixels.
			outline-width = 0;
		};
	};

}
