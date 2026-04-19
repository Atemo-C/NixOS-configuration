{ config, pkgs, ... }: { home-manager.users = {
	${config.user.name} = rec {
		home.pointerCursor = {
			gtk.enable = true;
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Ice";
			size = 24;
		};

		gtk = {
			cursorTheme = {
				package = home.pointerCusor.package;
				name = home.pointerCursor.name;
				size = home.pointerCursor.size;
			};

			iconTheme = {
				package = pkgs.flat-remix-icon-theme;
				name = "Flat-Remix-Blue-Dark";
			};
		};
	};

	root = rec {
		home.pointerCursor = {
			gtk.enable = true;
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Amber";
			size = 24;
		};

		gtk = {
			cursorTheme = {
				package = home.pointerCusor.package;
				name = home.pointerCursor.name;
				size = home.pointerCursor.size;
			};

			iconTheme = {
				package = pkgs.flat-remix-icon-theme;
				name = "Flat-Remix-Red-Dark";
			};
		};
	};
}; }