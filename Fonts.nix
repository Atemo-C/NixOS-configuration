# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Fonts
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=console.font
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.cache32Bit
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.hinting.style
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.emoji
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.monospace
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.sansSerif
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontconfig.defaultFonts.serif
# • https://search.nixos.org/options?channel=24.05&show=fonts.fontDir.enable
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.font.name
# • https://nix-community.github.io/home-manager/options.xhtml#opt-gtk.font.size
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings

{ config, pkgs, ... }: {

	# The font used for the virtual consoles. Can be null, a font name, or a path to a PSF font file.
	console.font = "Lat2-Terminus16";

	fonts = {
		fontconfig = {
			# Generate system fonts cache for 32-bit applications.
			cache32Bit = true;

			defaultFonts = {
				# System-wide default emoji font(s).
				# Multiple fonts may be listed in case a font does not support all emoji.
				# Note that fontconfig matches color emoji fonts preferentially.
				emoji = [ "Noto Color Emoji "];

				# System-wide default monospace font(s).
				# Multiple fonts may be listed in case multiple languages must be supported.
				monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];

				# System-wide default sans serif font(s).
				# Multiple fonts may be listed in case multiple languages must be supported.
				sansSerif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];

				# System-wide default serif font(s).
				# Multiple fonts may be listed in case multiple languages must be supported.
				serif = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
			};

			# Hintstyle is the amount of font reshaping done to line up to the grid.
			hinting.style = "slight";
		};

		# Whether to create a directory with links to all fonts in the /run/current-system/sw/share/X11/fonts directory.
		fontDir.enable = true;

		# Font packages used. Local fonts may be added in the $HOME/.local/share/fonts/ directory.
		packages =  [
			# UbuntuMono Nerd Fonts.
			(pkgs.unstable.nerdfonts.override { fonts = [ "UbuntuMono" ]; })

			# Noto Fonts and emojis.
			pkgs.unstable.noto-fonts
			pkgs.unstable.noto-fonts-cjk
			pkgs.unstable.noto-fonts-color-emoji
		];
	};

	home-manager.users.${config.custom.name} = {
		gtk.font = {
			# The family name of the font to use in GTK+ 2/3 applications.
			name = "UbuntuMono Nerd Font";

			# The size of the font to use in GTK+ 2/3 applications.
			size = 11;
		};

		# Font family name for the Hyprland Wayland compositor.
		wayland.windowManager.hyprland.settings.misc = { font_family = "UbuntuMono Nerd Font"; };
	};

}
