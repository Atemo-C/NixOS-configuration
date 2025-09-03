{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable {
	environment.sessionVariables = {
		# Tell Adwaita-based programs to prefer a dark theme.
		ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
		#HDY_DEBUG_COLOR_SCHEME = "prefer-dark";

		# Tell QT apps to use the GTK3 platformtheme.
		QT_QPA_PLATFORMTHEME = "gtk3";
	};

	home-manager.users = {
		# GTK theming for the user.
		${config.userName} = {
			dconf.settings = {
				# Disable window buttons (minimize, maximize, close…) if desired.
				"org/gnome/desktop/wm/preferences" = { button-layout = "icon,appmenu:"; };

				# Whether to automatically hide scrollbars.
				"org/gnome/desktop/interface" = { overlay-scrolling = false; };

				# Whether to show status shapes in buttons etc.
				"org/gnome/desktop/a11y/interface" = { show-status-shapes = true; };
			};

			gtk = {
				# Enable GTK configuration.
				enable = true;

				theme = {
					# Package providing the theme.
					package = pkgs.flat-remix-gtk;

					# The name of the theme to use withing the package.
					name = "Flat-Remix-GTK-Blue-Darkest-Solid";
				};

				# Extra configuration lines to add to `~/.gtkrc-2.0`.
				gtk2.extraConfig = "
gtk-primary-button-wraps-slider = 1
gtk-toolbar-style = 3
gtk-menu-images = 1
gtk-button-images = 1
gtk-enable-mnemonics = 0
				";

				# Extra configuration options to add to `~/.config/gtk-3.0/settings.ini`.
				gtk3.extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-menu-images = true;
					gtk-toolbar-style = 3;
				};
			};

#			qt = {
#				# Whether to enable QT configuration through Home Manager.
#				enable = true;
#
#				# Make QT follow GSettings where possible.
#				platformTheme = "gnome";
#			};
		};

		# GTK theming for the root user.
		root = {
			# Disable window buttons (minimize, maximize, close…) if desired.
			dconf.settings = { "org/gnome/desktop/wm/preferences" = { button-layout = "icon,appmenu:"; }; };

			gtk = {
				# Enable GTK configuration.
				enable = true;

				theme = {
					# Package providing the theme.
					package = pkgs.flat-remix-gtk;

					# The name of the theme to use withing the package.
					name = "Flat-Remix-GTK-Red-Darkest-Solid";
				};

				# Extra configuration lines to add to `~/.gtkrc-2.0`.
				gtk2.extraConfig = "
gtk-primary-button-wraps-slider = 1
gtk-toolbar-style = 3
gtk-menu-images = 1
gtk-button-images = 1
gtk-enable-mnemonics = 0
				";

				# Extra configuration options to add to `~/.config/gtk-3.0/settings.ini`.
				gtk3.extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-menu-images = true;
					gtk-toolbar-style = 3;
				};
			};
		};
	};
}