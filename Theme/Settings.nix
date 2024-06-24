{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name} = {
		# Whether to enable GTK 2/3 configuration.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.enable
		gtk.enable = true;

		# Whether to enable QT 5 and 6 configuration.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-qt.enable
		qt.enable = true;
	};

	# Whether to enable Qt configuration, including theming.
	# https://search.nixos.org/options?channel=24.05&show=qt.enable
	qt.enable = true;

}
