# Used NixOS packages:
#─────────────────────
# • [libreoffice]
#   https://libreoffice.org/
#
# • [xreader]
#   https://github.com/linuxmint/xreader

{ pkgs, ... }: { environment.systemPackages = [

	# Comprehensive, professional-quality productivity suite, a variant of openoffice.org.
	pkgs.libreoffice-fresh

	# A document viewer capable of displaying multiple and single page document formats like PDF and Postscript.
	pkgs.cinnamon.xreader

]; }
