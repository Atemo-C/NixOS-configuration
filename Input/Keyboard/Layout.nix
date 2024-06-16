{ config, ... }: {

	# Keyboard layout for graphical environment.
	# https://search.nixos.org/options?channel=24.05&show=services.xserver.xkb.layout
	services.xserver.xkb.layout = "fr";

	# Keyboard layout for virtual consoles.
	# # https://search.nixos.org/options?channel=24.05&show=console.keyMap
	console.keyMap = "fr";

}
