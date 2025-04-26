{ config, pkgs, ... }: {

	i18n.inputMethod = {
		# Whether to enable an additional input method type.
		enable = true;

		# Input method to be used.
		type = "fcitx5";

		# Enabled Fcitx5 addons.
		fcitx5.addons = [
			pkgs.fcitx5-gtk
			pkgs.fcitx5-configtool
		];
	};

	# If `i18n.inputMethod.type` is `fcitx5`, add it to startup programs in the Hyprland Wayland compositor.
	home-manager.users.${config.userName}.wayland.windowManager.hyprland.settings.exec-once = [
		( if config.i18n.inputMethod.type == "fcitx5" then "fcitx5" else null )
	];

}
