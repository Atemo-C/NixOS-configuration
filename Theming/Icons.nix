# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.gtk.enable
# • https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.package
# • https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.name
# • https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.size
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.cusorTheme.package
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.cusorTheme.name
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.cusorTheme.size
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.iconTheme.package
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.iconTheme.name

{ config, pkgs, ... }: { home-manager.users.${config.custom.name} = {

	home.pointerCursor = {
		# Whether to enable gtk config generation for home.pointerCursor .
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
			package = pkgs.bibata-cursors;

			# The name of the cursor theme within the package.
			name = "Bibata-Modern-Ice";

			# The size of the cursor.
			size = 24;
		};

		iconTheme = {
			# Package providing the icon theme.
			package = pkgs.flat-remix-icon-theme;

			# The name of the icon theme within the package.
			name = "Flat-Remix-Blue-Dark";
		};
	};

}; }