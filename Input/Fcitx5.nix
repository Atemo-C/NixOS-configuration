{ config, pkgs, ... }: let

	hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	i18n.inputMethod = if hyprland then {
		# If Hyprland is enabled, enable an additional input method type.
		enable = true;

		# Additional input method type to be used.
		type = "fcitx5";

		# Fcitx5 addons to enable.
		fcitx5.addons = [
			pkgs.fcitx5-gtk
			pkgs.fcitx5-configtool
		];
	} else {};

	# If Hyprland is enabled, start the relevant additional input method type when logging into Hyprland.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = if hyprland then
		[ "fcitx5" ] else [];

}
