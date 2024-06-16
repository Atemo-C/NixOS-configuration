{ config, pkgs, ... }: {

	fonts.packages = with pkgs; [

		# UbuntuMono Nerd Fonts.
		(unstable.nerdfonts.override {
			fonts = [ "UbuntuMono" ];
		})

		# Noto Fonts and emojis.
		noto-fonts
		noto-fonts-cjk
		noto-fonts-color-emoji
	];

}
