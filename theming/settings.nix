{ config, lib, pkgs, ... }: {
	environment.sessionVariables = {
		# Tell Adwaita-based programs to prefer a dark theme.
		ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
		#HDY_DEBUG_COLOR_SCHEME = "prefer-dark";

		# Tell QT-based programs to use the GTK3 platformtheme.
		QT_QPA_PLATFORMTHEME = "gtk3";
	};

	home-manager.users = {
		# GTK theming for the normal user.
		${config.userName} = {
			dconf.settings = {
				# Disable window buttons (minimize, maximize, close).
				"org/gnome/desktop/wm/preferences" = lib.mkIf config.programs.niri.enable { button-layout = "icon,appmenu:"; };

				# Whether to automatically hide scrollbars.
				"org/gnome/desktop/interface" = { overlay-scrolling = false; };

				# Whether to show status shapes in buttons etc.
				"org/gnome/desktop/a11y/interface" = { show-status-shapes = true; };
			};

			gtk = {
				# Whether to enable GTK configuration.
				enable = true;

				theme = {
					# Package providing the theme.
					package = pkgs.flat-remix-gtk;

					# The name of the theme to use within the package.
					name = "Flat-Remix-GTK-Blue-Darkest-Solid";
				};

				# Extra configuration for GTK2 programs.
				gtk2.extraConfig = "
					gtk-primary-button-wraps-slider = 1
					gtk-toolbar-style = 3
					gtk-menu-images = 1
					gtk-button-images = 1
					gtk-enable-mnemonics = 0
				";

				# Extra configuration for GTK3 programs.
				gtk3.extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-menu-images = true;
					gtk-toolbar-style = 3;
				};
			};
		};

		# GTK theming for the root user.
		root = {
			dconf.settings = {
				# Disable window buttons (minimize, maximize, close).
				"org/gnome/desktop/wm/preferences" = lib.mkIf config.programs.niri.enable { button-layout = "icon,appmenu"; };

				# Whether to automatically hide scrollbars.
				"org/gnome/desktop/interface" = { overlay-scrolling = false; };

				# Whether to show status shapes in buttons etc.
				"org/gnome/desktop/a11y/interface" = { show-status-shapes = true; };
			};

			gtk = {
				# Whether to enable GTK configuration.
				enable = true;

				theme = {
					# Package providing the theme.
					package = pkgs.flat-remix-gtk;

					# The name of the theme to use within the package.
					name = "Flat-Remix-GTK-Red-Darkest-Solid";
				};

				# Extra configuration for GTK2 programs.
				gtk2.extraConfig = "
					gtk-primary-button-wraps-slider = 1
					gtk-toolbar-style = 3
					gtk-menu-images = 1
					gtk-button-images = 1
					gtk-enable-mnemonics = 0
				";

				# Extra configuration for GTK3 programs.
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