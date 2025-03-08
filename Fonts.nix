{ config, pkgs, ... }: {

	# The font used for the virtual consoles.
	console.font = "Lat2-Terminus16";

	fonts = {
		# Whether to install a basic set of fonts providing several styles and families.
		# It also provides a reasonable coverage of Unicode.
		enableDefaultPackages = true;

		# Whether to create a directory with links to all fonts in /run/current-system/sw/share/X11/fonts.
		fontDir.enable = true;

		fontconfig = {
			# Whether to generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			# Default fonts to use, per category.
			# Multiple fonts may be listed in case one does not support certain characters, such as emojis.
			defaultFonts = {
				# Default emoji font(s).
				emoji = [ "Noto Color Emoji" ];

				# Default monospace font(s).
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];

				# Default Sans-Serif font(s).
				sansSerif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];

				# Default Serif font(s).
				serif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
			};
		};

		# List of primary font packages.
		packages = with pkgs; [
			# Ubuntu Nerd Fonts.
			nerd-fonts.ubuntu
			nerd-fonts.ubuntu-mono

			# Noto Fonts and emojis.
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-color-emoji
		];
	};

	# Fonts to be used for the user.
	home-manager.users.${config.custom.name} = {
		gtk.font = {
			# The family name of the font to use in compatible GTK applications.
			name = "UbuntuMono Nerd Font";

			# The size of the font to use in compatible GTK applications.
			size = 11;
		};
	};

}
