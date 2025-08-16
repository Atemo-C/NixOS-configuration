{ config, lib, pkgs, ... }: {
	home-manager.users.${config.userName}.programs.fuzzel = lib.mkIf config.programs.niri.enable {
		# Whether to enable the Fuzzel launcher.
		enable = true;

		# Fuzzel settings, written to `~/.config.fuzzel/fuzzel.ini`.
		settings = {
			border = {
				# Width of the border in pixels.
				width = 2;

				# Rounding of the corners in pixels.
				radius = 0;
			};

			colors = {
				background = "0d0d0dcc";
				border = "0080ffcc";
				input = "e6ffffff";
				match = "ff0080ff";
				prompt = "00ffffcc";
				selection = "2073ff88";
				selection-text = "ffffffff";
				selection-match = "00ffffff";
				text = "ffffffff";
			};

			main = rec {
				# Use a font defined in the `./theming/fonts.nix` module.
				font = "monospace:size=12.5";

				# Horizontal, vertical, and inner padding in pixels.
				horizontal-pad = 6;
				inner-pad = horizontal-pad;
				vertical-pad = horizontal-pad;

				# Use the icon theme set for the user in the `./theming/icons.nix` module.
				icon-theme = "${config.home-manager.users.${config.userName}.gtk.iconTheme.name}";

				# Line height in pixels.
				line-height = 20;

				# Whether to use bold text for selected items.
				# Works best with mono-spaced fonts.
				use-bold = "yes";
			};
		};
	};
}
