{ lib, ... }: rec {
	programs.foot = {
		# Whether to enable the Foot terminal emulator.
		enable = true;

		# Foot's settigs.
		settings = {
			# Opacity of the window background.
			# The colorscheme can be edited in the `/etc/nixos/theming/terminal-colors.nix` module.
			colors.alpha = "0.9";

			# Use the default monospace font with a custom size.
			# Fonts are handled in the `/etc/nixos/theming/fonts.nix` module.
			main.font = "monospace:size=12";

			# Modified search key binding that feels more natural.
			key-bindings.search-start = "Control+Shift+f";

			# NUmber of lines to keep in memory.
			scrollback.lines = 10000;
		};
	};

	xdg.terminal-exec = {
		# Whether to enable `xdg-terminal-exec`;
		# The proposed Default Terminal Execution Specification.
		enable = true;

		# Set the default terminal emulator.
		settings.default = lib.optional programs.foot.enable "+footclient.desktop";
	};
}