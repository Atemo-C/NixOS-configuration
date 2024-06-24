{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name}.gtk.iconTheme = {
		# Package providing the icon theme.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.iconTheme.package
		package = pkgs.kdePackages.breeze-icons;

		# The name of the icon theme within the package.
		# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.iconTheme.name
		name = "breeze-dark";
	};

}
