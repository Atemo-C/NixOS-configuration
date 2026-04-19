{ config, lib, pkgs, ... }: {
	environment.sessionVariables = {
		ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
		#HDY_DEBUG_COLOR_SCHEME = "prefer-dark";
		QT_QPA_PLATFORMTHEME = "gtk3";
	};

	home-manager.users = {
		${config.user.name} = {
			dconf.settings = {
				"org/gnome/desktop/wm/preferences" = lib.mkIf config.programs.niri.enable { button-layout = "icon,appmenu:"; };
				"org/gnome/desktop/interface" = { overlay-scrolling = false; };
				"org/gnome/desktop/a11y/interface" = { show-status-shapes = true; };
			};

			gtk = {
				enable = true;

				theme = {
					package = pkgs.flat-remix-gtk;
					name = "Flat-Remix-GTK-Blue-Darkest-Solid";
				};

				gtk2.extraConfig "
					gtk-primary-button-wraps-slider = 1
					gtk-toolbar-style = 3
					gtk-menu-images = 1
					gtk-button-images = 1
					gtk-enable-mnemonics = 0
				";

				gtk3.extraConfig = {
					gtk-application-prefer-dark-theme = true;
					gtk-button-images = true;
					gtk-menu-images = true;
					gtk-toolbar-style = 3;
				};
			};
		};

		root = {
			dconf.settings = {
				"org/gnome/desktop/wm/preferences" = lib.mkIf config.programs.niri.enable { button-layout = "icon,appmenu:"; };
				"org/gnome/desktop/interface" = { overlay-scrolling = false; };
				"org/gnome/desktop/a11y/interface" = { show-status-shapes = true; };
			};

			gtk = {
				enable = true;

				theme = {
					package = pkgs.flat-remix-gtk;
					name = "Flat-Remix-GTK-Red-Darkest-Solid";
				};

				gtk2.extraConfig "
					gtk-primary-button-wraps-slider = 1
					gtk-toolbar-style = 3
					gtk-menu-images = 1
					gtk-button-images = 1
					gtk-enable-mnemonics = 0
				";

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