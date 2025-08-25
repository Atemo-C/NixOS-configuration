{ config, lib, ... }: let
	# Shortcuts to check if Foot and the Foot server are enabled.
	# Foot and the Foot server are toggleable here;
	foot       = config.home-manager.users.${config.userName}.programs.foot.enable;
	footserver = config.home-manager.users.${config.userName}.programs.foot.server.enable;

in {
	# Set the default terminal emulator.
	environment.variables = lib.mkIf foot {
		TERMINAL = if (foot && footserver) then "footclient" else "foot";
	};

	home-manager.users.${config.userName}.programs.foot = rec {
		# Whether to enable the Foot terminal emulator.
		enable = true;

		# Whether to enable the Foot terminal emulator's server.
		# Lower memory usage, but worse performances across opened terminal instances if one is struggling.
		server.enable = lib.mkIf enable true;

		# Foot configuration (colors are set in the `./theming/terminal-colors.nix` module).
		settings = lib.mkIf enable {
			# Opacity of the window background.
			colors.alpha = "0.8";

			# Use the monospace font defined in the `./theming/fonts.nix` module.
			main.font = "monospace:size=12";

			# Modified search key bindings.
			key-bindings.search-start = "Control+Shift+f";

			# Number of lines to keep in memory.
			scrollback.lines = 10000;
		};
	};
}