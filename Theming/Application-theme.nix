{ config, pkgs, ... }: { home-manager.users.${config.custom.name}.gtk.theme = {

	# Package providing the theme.
	package = pkgs.flat-remix-gtk;

	# The name of the theme to use within the package.
	name = "Flat-Remix-GTK-Blue-Darkest-Solid";

}; }
