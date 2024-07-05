{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Image editing.
		gimp

		# Painting.
		krita

		# Vector graphics editor.
		inkscape

		# 2D sprite editor.
		pixelorama

		# The GOAT of image manipulation.
		imagemagick
	];

}
