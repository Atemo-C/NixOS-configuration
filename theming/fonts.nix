{ pkgs, ... }: { fonts = {
	# Enable a basic set of fonts providing a reasonable coverage of Unicode.
	enableDefaultPackages = true;

	# Whether to link all fonts in `/run/current-system/sw/share/X11/fonts`.
	fontDir.enable = true;

	fontconfig = {
		# Whether to generate system fonts cache for 32-bit applications.
		cache32Bit = true;

		# System-wide fonts to use.
		defaultFonts = {
			emoji = [ "Noto Color Emoji" ];
			monospace = [ "UbuntuMono Nerd Font" "Noto Color Emoji" ];
			sansSerif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
			serif = [ "Ubuntu Nerd Font" "Noto Color Emoji" ];
		};
	};

	# List of primary font packages to install.
	packages = with pkgs; [
		nerd-fonts.ubuntu
		nerd-fonts.ubuntu-mono
		nerd-fonts.ubuntu-sans
		noto-fonts-cjk-sans
		noto-fonts
	];
}; }