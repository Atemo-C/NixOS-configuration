# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Keyboard_Layout_Customization
# • https://wiki.nixos.org/wiki/ZSA_Keyboards
# • https://wiki.hyprland.org/Configuring/Variables/#input
#
# Used NixOS packages:
#─────────────────────
# • [wally-cli]
#   https://ergodox-ez.com/pages/wally-planck
#
# • [keymapp]
#   https://www.zsa.io/flash/
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=console.keyMap
# • https://search.nixos.org/options?channel=24.05&show=hardware.keyboard.zsa.enable
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings



{ config, pkgs, ... }: {

	# The keyboard mapping table for the virtual consoles.
	console.keyMap = "fr";

	# GUI and CLI flashing utilities for ZSA keyboards.
	environment.systemPackages = [ pkgs.keymapp pkgs.wally-cli ];

	# Whether to enable udev rules for keyboards from ZSA.
	# Needed to flash a new configuration on the keyboard or use their live training in the browser.
	hardware.keyboard.zsa.enable = true;

	# Keyboard settings for the Hyprland Wayland compositor.
	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.input = {
		# Keyboard layout (XKB keymap parameter).
		kb_layout = "fr";

		# Whether to engage numlock by default.
		numlock_by_default = true;

		# Delay before a held-down key is repeated, in milliseconds.
		repeat_delay = "200";

		# The repeat rate for held-down keys, in repeats per second.
		repeat_rate = "30";
	};

}
