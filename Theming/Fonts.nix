{ config, pkgs, ... }: let

	hyprland  = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;
	alacritty = config.home-manager.users.${config.userName}.programs.alacritty.enable;

in {

	fonts = {
		# Whether to enable a basic set of fonts to provide a reasonable coverage of Unicode.
		# Especially useful for emojis (Noto Color Emoji) and legacy characters support.
		enableDefaultPackages = true;

		# Whether to link system fonts to `/run/current-system/sw/share/X11/fonts` for easier access.
		# Some programs and Flatpaks require this.
		fontDir.enable = true;

		fontconfig = {
			# Whether to generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			# Default fonts to use, per category.
			# Multiple fonts may be listed in case one does not support certain characters, such as emojis.
			defaultFonts = {
				emoji     = [ "Noto Color Emoji" ];
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				sansSerif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
				serif     = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
			};
		};

		# Additional font packages to install.
		packages = [
			# Ubuntu Nerd Fonts.
			pkgs.nerd-fonts.ubuntu
			pkgs.nerd-fonts.ubuntu-mono

			# Additional symbols and interlingual support.
			pkgs.noto-fonts-cjk-sans
			pkgs.noto-fonts
		];
	};

	# Font settings for the user.
	home-manager.users = {
		${config.userName} = {
			# If Alacritty is enabled, configure its fonts.
			programs.alacritty.settings.font = if alacritty then {
				normal = {
					# Font to use.
					family = "UbuntuMono Nerd Font";

					# Default style for the text.
					style = "Regular";
				};

				# Font styles.
				bold.style = "Bold";
				italic.style = "Italic";
				bold_italic.style = "Bold Italic";

				# Font size.
				size = 12.0;
			} else {};

			# If Hyprland is enabled, configure fonts for the Dunst notification daemon.
			services.dunst.settings.global.font = if hyprland then "UbuntuMono Nerd Font 12" else null;

			# If Hyprland is enabled, configure its fonts.
			wayland.windowManager.hyprland.settings = if hyprland then {
				# Font to use globally.
				misc.font_family = "UbuntuMono Nerd Font Bold";

				# Font size of groupbar titles.
				group.groupbar.font_size = 12;
			} else {};

			# If Hyprland is enabled, configure fonts for the Tofi menu.
			programs.tofi.settings = if hyprland then {
				# Exact path of the font to use. Drastically improves the already speedy startup times.
				font = "/run/current-system/sw/share/X11/fonts/UbuntuMonoNerdFont-Regular.ttf";

				# Font size.
				font-size = 12;

				# Whether to enable font hinting.
				hint-font = false;
			} else {};

			# Font settings for graphical programs.
			gtk.font = {
				# Font to use in graphical programs.
				name = "UbuntuMono Nerd Font";

				# Font size to use in graphical programs.
				size = 11;
			};
		};

		# Font settings for the root user.
		root.gtk.font = {
			# Font to use in graphical programs.
			name = "UbuntuMono Nerd Font";

			# Font size to use in graphical programs.
			size = 11;
		};
	};

}
