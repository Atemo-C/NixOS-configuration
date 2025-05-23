{ config, lib, pkgs, ... }: let

	# Hyprland check for Hyprland and Hyprland utilities-specific theming.
	hyprland = config.enableHyprland;

in {

	# Tell Adwaita-based programs to prefer a dark theme.
	environment.sessionVariables = {
		ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
#		HDY_DEBUG_COLOR_SCHEME = "prefer-dark";
	};

	home-manager.users = {
		# GTK and QT settings for the user.
		${config.userName} = {
			# Settings to write to the dconf configuration system.
			# Here, sets the desired window icons layout.
			dconf.settings = lib.optionalAttrs hyprland
				{ "org/gnome/desktop/wm/preferences" = { button-layout = "icon,appmenu:"; }; };

			gtk = {
				# Enable GTK 2/3 configuration.
				enable = true;

				# Extra configuration lines to add verbatim to ~/.gtkrc-2.0.
				gtk2.extraConfig = "
					gtk-primary-button-wraps-slider = 1
					gtk-toolbar-style = 3
					gtk-menu-images = 1
					gtk-button-images = 1
					gtk-enable-mnemonics = 0
				";

				# Extra configuration options to add to $XDG_CONFIG_HOME/gtk-3.0/settings.ini.
				gtk3.extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-menu-images = true;
					gtk-toolbar-style = 3;
				};
			};

			qt = {
				# Whether to enable Qt configuration.
				enable = true;

				# Style to use for Qt applications.
				style.name = "gtk2";
			};
		};

		# GTK and QT settings for the root user.
		root = {
			# Settings to write to the dconf configuration system.
			# Here, sets the desired window icons layout.
			dconf.settings = lib.optionalAttrs hyprland
				{ "org/gnome/desktop/wm/preferences" = { button-layout = "icon,appmenu:"; }; };

			gtk = {
				# Enable GTK 2/3 configuration.
				enable = true;

				# Extra configuration lines to add verbatim to ~/.gtkrc-2.0.
				gtk2.extraConfig = "
					gtk-primary-button-wraps-slider = 1
					gtk-toolbar-style = 3
					gtk-menu-images = 1
					gtk-button-images = 1
					gtk-enable-mnemonics = 0
				";

				# Extra configuration options to add to $XDG_CONFIG_HOME/gtk-3.0/settings.ini.
				gtk3.extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-menu-images = true;
					gtk-toolbar-style = 3;
				};
			};

			qt = {
				# Whether to enable Qt configuration.
				enable = true;

				# Style to use for Qt applications.
				style.name = "gtk2";
			};
		};
	};

	qt = {
		# Whether to enable Qt configuration, including theming.
		enable = true;

		# Selects the platform theme to use for Qt applications.
		platformTheme = "gtk2";

		# Selects the style to use for Qt applications.
		style = "gtk2";
	};

}
