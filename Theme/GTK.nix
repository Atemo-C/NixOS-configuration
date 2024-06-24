{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name} = {
		gtk = {
			theme = {
				# Package providing the theme.
				# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.theme.package
				package = pkgs.kdePackages.breeze-gtk;

				# The name of the theme within the package.
				# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.theme.name
				name = "Breeze-Dark";
			};

			# Extra configuration options.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk3.extraConfig
			gtk3.extraConfig = {
				gtk-application-prefer-dark-theme = true;
				gtk-button-images = true;
				gtk-decoration-layout = "";
				gtk-menu-images = true;
			};

			# Extra conifguration options.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk4.extraConfig
			gtk4.extraConfig = {
				gtk-application-prefer-dark-theme = true;
				gtk-button-images = true;
				gtk-decoration-layout = "";
				gtk-menu-images = true;
			};
		};
	};

}
