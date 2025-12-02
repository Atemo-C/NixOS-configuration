{ config, lib, ... }: lib.mkIf config.programs.niri.enable {
home-manager.users.${config.userName}.programs.fuzzel = {
	# Whether to enable the Fuzzel launcher.
	enable = true;

	# Width of the border in pixels.
	settings.border.width = 2;

	# Rounding of the corners in pixels.
	settings.border.radius = 0;

	settings.colors = rec {
		background      = "0d0d0dcc";
		border          = "0080ffcc";
		input           = "e6ffffff";
		match           = "ff0080ff";
		prompt          = "00ffffcc";
		selection       = "2073ff88";
		selection-text  = text;
		selection-match = "00ffffff";
		text            = "ffffffff";
	};

	settings.main = rec {
		# Use a font defined in the `./theming/fonts.nix` module.
		font = "monospace:size=12.5";

		# Padding in pixels.
		horizontal-pad = 6;
		inner-pad = horizontal-pad;
		vertical-pad = horizontal-pad;

		# Use the icon theme set for the user in the `./theming/icons.nix` module.
		icon-theme = "${config.home-manager.users.${config.userName}.gtk.iconTheme.name}";

		# Line height in pixels.
		line-height = 20;

		# Whether to use bold text for selected items. Works best with mono-spaced fonts.
		use-bold = "yes";
	};
}; }