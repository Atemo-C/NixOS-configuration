{ config, pkgs, ... }: {
	home-manager.users = {
		# Icon and cursor theming for the normal user.
		${config.userName} = rec {
			home.pointerCursor = {
				# Whether to enable GTK configuration generation for `home.pointerCursor`.
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

					# The cursor name within the package.
					name = home.pointerCursor.name;

					# The cursor size.
					size = home.pointerCursor.size;
				};

				iconTheme = {
					# Package providing the icon theme.
					package = pkgs.flat-remix-icon-theme;

					# The name of the icon theme within the package.
					name = "Flat-Remix-Blue-Dark";
				};
			};
		};

		# Icon and cursor themnig for the root user.
		root = rec {
			home.pointerCursor = {
				# Whether to enable GTK configuration generation for `home.pointerCursor`.
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

					# The cursor name within the package.
					name = home.pointerCursor.name;

					# The cursor size.
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
	};
}