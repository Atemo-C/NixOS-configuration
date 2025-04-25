{ config, pkgs, ... }: { home-manager.users = {

	# Theme for the user.
	${config.userName}.gtk.theme = {

		# Package providing the theme.
		package = pkgs.flat-remix-gtk;

		# The name of the theme to use within the package.
		name = "Flat-Remix-GTK-Blue-Darkest-Solid";
	};

	# Theme for the root user.
	root.gtk.theme = {
		# Package providing the theme.
		package = pkgs.flat-remix-icon-theme;

		# The name of the theme to use within the package.
		name = "Flat-Remix-GTK-Red-Darkest-Solid";
	};

}; }
