{ pkgs, ... }: { environment.systemPackages = with pkgs; [
	# Office suite.
	libreoffice-fresh

	# Document viewer.
	papers

	# PDF rendering library.
	poppler-utils
]; }