{ config, pkgs, ... }: { i18n.inputMethod = {

	# Whether to enable an additional input method type.
	enable = true;

	# Input method to be used.
	type = "fcitx5";

	# Enabled Fcitx5 addons.
	fcitx5.addons = with pkgs; [
		fcitx5-gtk
		fcitx5-configtool
	];

}; }
