# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=environment.sessionVariables
# • https://search.nixos.org/options?channel=24.05&show=qt.enable
# • https://search.nixos.org/options?channel=24.05&show=qt.style
#
# Used Home Manager options:
#───────────────────────────
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-dconf.settings
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-gtk.enable
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk2.extraConfig
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-gtk.gtk3.extraConfig
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-qt.enable
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-qt.style
# • ttps://nix-community.github.io/home-manager/options.xhtml#opt-qt.platformTheme


{ config, ... }: {

	# Tell Adwaita-based programs to prefer a dark theme.
	environment.sessionVariables = {
		ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
#		HDY_DEBUG_COLOR_SCHEME = "prefer-dark";
	};

	home-manager.users.${config.custom.name} = {
		# Settings to write to the dconf configuration system.
		# Here, sets the desired window icons layout.
		dconf.settings = { "org/gnome/desktop/wm/preferences" = { button-layout = "icon,appmenu:"; }; };

		gtk = {
			# Whether to enable GTK 2/3 configuration.
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
			# Whether to enable Qt 5 and 6 configuration.
			enable = true;

			# Style to use for Qt5/Qt6 applications.
			style.name = "adwaita-dark";
		};
	};

	qt = {
		# Whether to enable Qt configuration, including theming.
		enable = true;

		# Selects the style to use for Qt applications.
		style = "adwaita-dark";
	};

}
