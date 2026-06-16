{ config, lib, ... }: {
	programs.foot = {
		# Whether to enable the Foot terminal emulator.
		enable = true;

		# Foot's settings.
		settings = {
			# Use the default monospace font with a custom size.
			# Fonts are handled in the `/etc/nixos/theming/fonts.nix` module.
			main.font = "monospace:size=12";

			# Modified search key binding that feels more natural.
			key-bindings.search-start = "Control+Shift+f";

			# Number of lines to keep in memory.
			scrollback.lines = 10000;
		};
	};

	xdg.terminal-exec = {
		# Whether to enable `xdg-terminal-exec`,
		# the proposed Default Terminal Emulator Specification.
		enable = true;

		# Set the default terminal emulator.
		settings.default = lib.optional config.programs.foot.enable "+footclient.desktop";
	};
}
