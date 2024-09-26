# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=console.colors
# • https://search.nixos.org/options?channel=24.05&show=console.earlySetup

{ config, ... }: { console = {

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

}; }
