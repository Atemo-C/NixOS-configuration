{ config, ... }: {

	# Linux console (TTY) colors.
	console = {
		# The 16 colors palette used by the virtual consoles.
		colors = [
			"000000" # Black
			"ff0000" # Red
			"00ff00" # Green
			"ffc000" # Yellow
			"0080ff" # Blue
			"ff00ff" # Magenta
			"00ffff" # Cyan
			"dddddd" # White
			"333333" # Bright black
			"ff4d4d" # Bright red
			"80ff80" # Bright green
			"ffd966" # Bright yellow
			"66b3ff" # Bright blue
			"ff66ff" # Bright magenta
			"80ffff" # Bright cyan
			"ffffff" # Bright white
		];

		# Enable setting virtual console options as early as possible (in initrd).
		earlySetup = true;
	};

	# Alacritty colors.
	home-manager.users.${config.userName}.programs.alacritty.settings.colors = {
		primary = {
			background = "#000000";
			foreground = "#eeeeee";
		};
		dim = {
			black = "#000000";
			blue = "#005ab3";
			cyan = "#00b3b3";
			green = "#00b300";
			magenta = "#b3005a";
			red = "#b30000";
			white = "#b3b3b3";
			yellow = "#b38600";
		};
		normal = {
			black = "#141414";
			blue = "#0080ff";
			cyan = "#00ffff";
			green = "#00ff00";
			magenta = "#ff0080";
			red = "#ff0000";
			white = "#e6e6e6";
			yellow = "#ffc000";
		};
		bright = {
			black = "#333333";
			blue = "#66b3ff";
			cyan = "#66ffff";
			green = "#66ff66";
			magenta = "#ff66b3";
			red = "#ff6666";
			white = "#ffffff";
			yellow = "#ffd966";
		};
	};

}
