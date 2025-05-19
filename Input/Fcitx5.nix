{ config, lib, pkgs, ... }: let

	# Hyprland check for Fcitx5.
	# Hyprland is toggleable in the `./Hyprland/Enable.nix` module.
	hyprland = config.enableHyprland;

in {

	i18n.inputMethod = lib.optionalAttrs hyprland {
		# Enable an additional input method type in Hyprland.
		enable = true;

		# Additional input method type to be used.
		type = "fcitx5";

		# Fcitx5 addons to enable.
		fcitx5.addons = [
			pkgs.fcitx5-gtk
			pkgs.fcitx5-configtool
		];
	};

	# Start the relevant additional input method type when logging into Hyprland.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once =
		lib.optionalAttrs hyprland [ "fcitx5" ];

}
