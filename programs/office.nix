{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable { environment.systemPackages = with pkgs; [
	libreoffice-fresh # Comprehensive productivity suite; A variant of OpenOffice.org, itself of StarOffice.
	poppler-utils     # PDF rendering library.
	xreader           # Document viewer.
]; }