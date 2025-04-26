{ config, pkgs, ... }: {

	fonts = {
		# Whether to enable a basic set of fonts.
		# They provide several styles and families, and a reasonable coverage of Unicode.
		enableDefaultPackages = true;

		# Whether to create a directory with links to all system fonts in /run/current-system/sw/share/X11/fonts.
		fontDir.enable = true;

		fontconfig = {
			# Whether to generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			# Default fonts to use, per category.
			# Multiple fonts may be listed in caseo ne does not support certain characters, such as emojis.
			defaultFonts = {
				emoji = [ "Noto Color Emoji" ];
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				sansSerif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				serif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
			};
		};

		# List of additional font packages to install.
		packages = [
			# Ubuntu Nerd Fonts.
			pkgs.nerd-fonts.ubuntu
			pkgs.nerd-fonts.ubuntu-mono

			# Other font packages for additional symbols support.
			pkgs.noto-fonts-cjk-sans
		];
	};

	# Fonts managed by Home Manager.
	home-manager.users = {
		${config.userName} = {
			# Font settings for Dunst notifications.
			services.dunst.settings.global.font = "UbuntuMono Nerd Font 12";

			# Font settings for graphical programs.
			gtk.font = {
				# The family name of the font to use in compatible GTK applications.
				name = "UbuntuMono Nerd Font";

				# The size of the font to use in compatible GTK applications.
				size = 11;
			};

			# Font settings for the Hyprland Wayland compositor.
			wayland.windowManager.hyprland.settings = {
				# Set the global default font for Hyprland.
				misc.font_family = "UbuntuMono Nerd Font Bold";

				# Font size of groupbar titles.
				group.groupbar.font_size = 12;
			};

			# Font settings for the Tofi menu.
			programs.tofi.settings = {
				# Font to use, either a path to a font file or a name.
				# If a CORRECT path is given, tofi will startup much quicker.
				# Otherwise, fonts are interpreted in Pango format.
				font = "/run/current-system/sw/share/X11/fonts/UbuntuMonoNerdFont-Regular.ttf";

				# Point size of the text.
				font-size = 12;

				# Whether to enable font hinting.
				hint-font = false;
			};
		};

		root = {
			# Font settings for graphical programs.
			gtk.font = {
				# The family name of the font to use in compatible GTK applications.
				name = "UbuntuMono Nerd Font";

				# The size of the font to use in compatible GTK applications.
				size = 11;
			};
		};
	};

}
