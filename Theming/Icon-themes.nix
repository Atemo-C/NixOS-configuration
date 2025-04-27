{ config, pkgs, ... }: { home-manager.users = {

	# Icon and cursor theming for the user.
	${config.userName} = rec {
		home.pointerCursor = {
			# Enable GTK config generation for home.pointerCursor .
			gtk.enable = true;

			# Package providing the cursor theme.
			package = pkgs.bibata-cursors;

			# The cursor name within the package.
			name = "Bibata-Modern-Ice";

			# The cursor size.
			size = 24;
		};

		gtk = {
			cursorTheme = {
				# Package providing the cursor theme.
				package = home.pointerCursor.package;

				# The name of the cursor theme within the package.
				name = home.pointerCursor.name;

				# The size of the cursor.
				size = home.pointerCursor.size;
			};

			iconTheme = {
				# Package providing the icon theme.
				package = pkgs.flat-remix-icon-theme;

				# The name of the icon theme within the package.
				name = "Flat-Remix-Blue-Dark";
			};
		};

		# Icon settings for the Dunst notification daemon.
		services.dunst.settings.global = {
			# Set icon theme (only used for recursive icon lookup).
			icon_theme = "Flat-Remix-Blue-Dark";

			# Paths to default icons (only necessary when not using recursive icon lookup).
			icon_path = "$HOME/.nix-profile/share/icons/Flat-Remix-Blue-Dark/status/scalable/16/:$HOME/.nix-profile/share/icons/Flat-Remix-Blue-Dark/devices/scalable/";
		};
	};

	# Icon and cursor theming for the root user.
	root = rec {
		home.pointerCursor = {
			# Enable GTK config generation for home.pointerCursor .
			gtk.enable = true;

			# Package providing the cursor theme.
			package = pkgs.bibata-cursors;

			# The cursor name within the package.
			name = "Bibata-Modern-Amber";

			# The cursor size.
			size = 24;
		};

		gtk = {
			cursorTheme = {
				# Package providing the cursor theme.
				package = home.pointerCursor.package;

				# The name of the cursor theme within the package.
				name = home.pointerCursor.name;

				# The size of the cursor.
				size = home.pointerCursor.size;
			};

			iconTheme = {
				# Package providing the icon theme.
				package = pkgs.flat-remix-icon-theme;

				# The name of the icon theme within the package.
				name = "Flat-Remix-Red-Dark";
			};
		};
	};

}; }
