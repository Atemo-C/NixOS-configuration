{ config, pkgs, ... }: {

	# Environment variables.
	# These are mostly useful to define in Flatpak programs.
	# https://search.nixos.org/options?channel=24.05&show=environment.sessionVariables
#	environment.sessionVariables = {
#		ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
#		HDY_DEBUG_COLOR_SCHEME = "prefer-dark";
#	};

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

			# Extra configuration lines to add verbatim to ~/.gtkrc-2.0
			# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk2.extraConfig
			gtk2.extraConfig =
				"gtk-enable-animations = 0
			gtk-primary-button-wraps-slider = 1
			gtk-toolbar-style = 3
			gtk-menu-images = 1
			gtk-button-images = 1";

			gtk3 = {
				# Extra configuration options to add to $XDG_CONFIG_HOME/gtk-3.0/settings.ini.
				# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk3.extraConfig
				extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-decoration-layout = "icon:";
					gtk-menu-images = true;
					gtk-enable-animations = 0;
					gtk-modules = "colorreload-gtk-module:window-decoration-gtk-module";
					gtk-primary-wraps-slider = true;
					gtk-toolbar-style = 3;
				};

				# Extra configuration lines to add verbatim to $XDG_CONFIG_HOME/gtk-3.0/gtk.css
				# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk3.extraCss
				extraCss = "@import 'colors.css';";
			};

			gtk4 = {
				# Extra configuration options to add to $XDG_CONFIG_HOME/gtk-4.0/settings.ini.
				# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk4.extraConfig
				extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-decoration-layout = "icon:";
					gtk-enable-animations = 0;
				};
				# Extra configuration lines to add verbatim to $XDG_CONFIG_HOME/gtk-4.0/gtk.css
				# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk4.extraCss
				extraCss = "@import 'colors.css';";
			};
		};
	};

}
