{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable {
	fonts = {
		# Whether to enable a basic set of fonts to provide a reasonable coverage of Unicode.
		# Especially useful for emojis (Noto Color Emoji) & legacy characters support.
		enableDefaultPackages = true;

		# Whether to link system fonts to `/run/current-system/sw/share/X11/fonts` for easier access.
		# Some programs & Flatpaks require this.
		fontDir.enable = true;

		fontconfig = {
			# Whether to generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			# Default fonts to use, per category.
			# Multiple fonts may be listed in case one does not support certain characters, such as emojis.
			defaultFonts = {
				emoji     = [ "Noto Color Emoji" ];
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				sansSerif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
				serif     = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
			};

			# Whether to use embedded bitmaps in fonts like Calibri or Noto emojis.
			useEmbeddedBitmaps = true;
		};

		packages = with pkgs; [
			# Ubuntu Nerd Fonts.
			pkgs.nerd-fonts.ubuntu
			pkgs.nerd-fonts.ubuntu-mono

			# Additional symbols & interlingual support.
			pkgs.noto-fonts-cjk-sans
			pkgs.noto-fonts
		];
	};

	home-manager.users = {
		${config.userName}.gtk.font = {
			# Font to use in graphical programs for the user.
			name = "sans";

			# Font size to use in graphical programs for the user.
			size = 11;
		};

		root.gtk.font = {
			# Font to use in graphical programs for the root user.
			name = "sans";

			# Font size to use in graphical programs for the root user.
			size = 11;
		};
	};
}