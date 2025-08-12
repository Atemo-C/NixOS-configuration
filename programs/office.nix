{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		# Comprehensive, professional-quality productivity suite, a variant of openoffice.org.
		# Did you know: LibreOffice is based on OpenOffice, which in itself is based on StarOffice?
		libreoffice-fresh

		# PDF rendering library.
		poppler-utils

		# A document viewer capable of displaying multiple and single page document formats like PDF and Postscript.
		xreader
	]);
}