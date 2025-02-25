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

	# GTK configuration for Fcitx5.
	home-manager.users.${config.custom.name}.gtk = {
		gtk2.extraConfig = '' gtk-im-module = "fcitx" '';
		gtk3.extraConfig = { gtk-im-module = "fcitx"; };
		gtk4.extraConfig = { gtk-im-module = "fcitx"; };
	};
}
