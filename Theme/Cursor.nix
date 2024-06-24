{ config, pkgs, ... }: {

	home-manager.users.${config.Custom.Name} = {
		home.pointerCursor = {
			# Whether to enable gtk config generation for home.pointerCursor.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.gtk.enable
			gtk.enable = true;

			# Package providing the cursor theme.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.package
			package = pkgs.kdePackages.breeze;

			# The cursor narme within the package.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-home.pointerCursor.name
			name = "Breeze_Snow";
		};

		gtk.cursorTheme = {
			# Package providing the cursor theme.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.cursorTheme.package
			package = pkgs.kdePackages.breeze;

			# The name of the cursor theme within the package.
			# https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.cursorTheme.name
			name = "Breeze_Snow";
		};
	};

}
