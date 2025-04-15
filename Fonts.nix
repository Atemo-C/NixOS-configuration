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
				sansSerif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
				serif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
			};
		};

		# List of additional font packages to install.
		packages = with pkgs; [
			# Ubuntu Nerd Fonts.
			nerd-fonts.ubuntu
			nerd-fonts.ubuntu-mono

			# Other font packages for additional symbols support.
			noto-fonts-cjk-sans
		];
	};

	# Fonts managed by Home Manager.
	home-manager.users = {
		${config.custom.name} = {
			gtk.font = {
				# The family name of the font to use in compatible GTK applications.
				name = "Ubuntu Nerd Font";

				# The size of the font to use in compatible GTK applications.
				size = 10;
			};
		};
		root = {
			gtk.font = {
				# The family name of the font to use in compatible GTK applications.
				name = "Ubuntu Nerd Font";

				# The size of the font to use in compatible GTK applications.
				size = 10;
			};
		};
	};

}
