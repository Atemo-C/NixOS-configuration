{ config, pkgs, ... }: {
	fonts = {
		# Whether to enable a basic set of fonts to provide a reasonable coverage of Unicode.
		# Especially useful for emojis (Noto Color Emoji) and legacy characters support.
		enableDefaultPackages = true;

		# Whether to link system fonts to `/run/current-system/sw/share/X11/fonts` for easier access.
		# Some programs and Flatpaks require or benefit from it.
		fontDir.enable = true;

		fontconfig = {
			# Whether to generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			# Default fonts to use, per category.
			# Multiple fonts may be listed in case one does not support certain Characters, such as emojis.
			defaultFonts = {
				emoji = [ "Noto Color Emoji" ];
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				sansSerif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
				serif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
			};

			# Whethre to use embedded bitmaps in fonts like cCalibri or Noto emojis.
			useEmbeddedBitmaps = true;
		};

		# Font packages to install.
		packages = with pkgs; [
			# Ubuntu Nerd Fonts.
			nerd-fonts.ubuntu
			nerd-fonts.ubuntu-mono

			# Additional symbols and interlingual support.
			noto-fonts-cjk-sans
			noto-fonts
		];
	};

	home-manager.users = {
		# Font configuration for the normal  user.
		${config.userName}.gtk.font = {
			# Font to use in graphical programs.
			name = "sans";

			# Font size to use in graphical programs.
			size = 11;
		};

		# Font configuration for the root  user.
		root.gtk.font = {
			# Font to use in graphical programs.
			name = "sans";

			# Font size to use in graphical programs.
			size = 11;
		};
	};
}