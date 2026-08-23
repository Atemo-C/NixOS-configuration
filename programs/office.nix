{ pkgs, ... }: { environment.systemPackages = with pkgs; [
	# Office suite.
	libreoffice

	# Document viewer.
	papers

	# PDF rendering library.
	poppler-utils
]; }