{ pkgs, ... }: { environment.systemPackages = [

	# Comprehensive, professional-quality productivity suite, a variant of openoffice.org.
	pkgs.libreoffice-fresh

	# PDF rendering library.
	pkgs.poppler-utils

	# A document viewer capable of displaying multiple and single page document formats like PDF and Postscript.
	pkgs.xreader

]; }
