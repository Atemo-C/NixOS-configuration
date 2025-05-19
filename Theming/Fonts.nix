{ config, lib, pkgs, ... }: let

	# Hyprland check for Hyprland and Hyprland utilities-specific theming.
	# Hyprland is toggleable in the `./Hyprland/Enable.nix` module.
	hyprland = config.enableHyprland;

	# Alacritty check for Alacritty-specific theming.
	# Alacritty is toggleable in the `./Programs/Terminal-emulators.nix` module.
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
				sansSerif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
				serif     = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
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
			programs.alacritty.settings.font = lib.optionalAttrs alacritty {
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
			};

			# If Hyprland is enabled, configure fonts for the Dunst notification daemon.
			services.dunst.settings.global.font = lib.optionalAttrs hyprland "UbuntuMono Nerd Font 12";

			# If Hyprland is enabled, configure its fonts.
			wayland.windowManager.hyprland.settings = lib.optionalAttrs hyprland {
				# Font to use globally.
				misc.font_family = "UbuntuMono Nerd Font Bold";

				# Font size of groupbar titles.
				group.groupbar.font_size = 12;
			};

			# If Hyprland is enabled, configure fonts for the Tofi menu.
			programs.tofi.settings = lib.optionalAttrs hyprland {
				# Exact path of the font to use. Drastically improves the already speedy startup times.
				font = "/run/current-system/sw/share/X11/fonts/UbuntuMonoNerdFont-Regular.ttf";

				# Font size.
				font-size = 12;

				# Whether to enable font hinting.
				hint-font = false;
			};

			# Font settings for graphical programs.
			gtk.font = {
				# Font to use in graphical programs.
				name = "Ubuntu Nerd Font";

				# Font size to use in graphical programs.
				size = 11;
			};
		};

		# Font settings for the root user.
		root.gtk.font = {
			# Font to use in graphical programs.
			name = "Ubuntu Nerd Font";

			# Font size to use in graphical programs.
			size = 11;
		};
	};

}
