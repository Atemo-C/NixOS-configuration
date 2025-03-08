{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# Comprehensive, professional-quality productivity suite, a variant of openoffice.org.
	libreoffice-fresh

	# A document viewer capable of displaying multiple and single page document formats like PDF and Postscript.
	xreader

]; }
