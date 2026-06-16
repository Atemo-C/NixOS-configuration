{ config, lib, pkgs, ... }: {
	environment = {
		systemPackages = with pkgs; [
			# Installer for the GNOME for Firefox theme.
			addwater

			# Installer for Adwaita-for-Steam.
			adwsteamgtk

			# Unofficial GTK 3 port of libadwaita.
			adw-gtk3

			# Material-based cursor theme.
			bibata-cursors

			# Icon theme inspired by material design.
			flat-remix-icon-theme
		];

		sessionVariables = {
			# For some reason, some programs refuse to use the dark mode.
			# This tries to force it.
			ADW_DEBUG_COLOR_SCHEME = "prefer-dark";

			# Tell Qt programs to use the GTK3 platformtheme.
			QT_QPA_PLATFORMTHEME = lib.mkIf (!config.qt.enable) "gtk3";
		};
	};

	programs.dconf = {
		# Whether to enable dconf.
		enable = true;

		profiles.user.databases = [{ settings = {
			"org/gnome/desktop/interface" = {
				# Whether buttons should have icons.
				buttons-have-icons = true;

				# Which color mode to prefer.
				color-scheme = "prefer-dark";

				# Cursor theme to use.
				cursor-theme = "Bibata-Modern-Ice";

				# Cursor size to use.
				cursor-size = lib.gvariant.mkInt32 24;

				# Font to use.
				font-name = "sans";

				# Icon theme to use.
				icon-theme = "Flat-Remix-Blue-Dark";

				# Whether to automatically hide scrollbars.
				overlay-scrolling = false;

				# Toolbar icon size.
				toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";

				# Toolbar style.
				toolbar-style = "GTK_TOOLBAR_ICONS";
			};

			# Whether to show status shapes in buttons.
			"org/gnome/desktop/a11y/interface" = { show-status-shapes = true; };

			"org/gnome/desktop/sound" = {
				# Whether to enable event sounds.
				event-sounds = lib.gvariant.mkBoolean true;

				# Whether to enable input feedback sounds.
				input-feedback-sounds = lib.gvariant.mkBoolean false;
			};
		}; }];
	};

	qt = {
		# Whether to enable Qt configuration, including theming.
		enable = true;

		# Select the style to use for Qt application.
		style = "kvantum";

		# Select the platform theme to use for Qt applications.
		platformTheme = "qt5ct";
	};

	# Link GTK and QT configuration files to the user's home directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.gtkrc-2.0 - - - - /etc/nixos/theming/files/gtkrc-2.0"
		"L %h/.config/gtk-3.0/settings.ini - - - - /etc/nixos/theming/files/gtk-3.0/settings.ini"
		"L %h/.config/gtk-4.0/ - - - - /etc/nixos/theming/files/gtk-4.0/"

		"L %h/.config/Kvantum/ - - - - /etc/nixos/theming/files/Kvantum/"
		"L %h/.config/qt5ct/ - - - - /etc/nixos/theming/files/qt5ct/"
		"L %h/.config/qt6ct/ - - - - /etc/nixos/theming/files/qt6ct/"
	];
}