{ pkgs, ... }: { environment.systemPackages = [

	# GTK algebraic and RPN calculator.
	pkgs.galculator

	# A simple and elegant clock application from GNOME.
	pkgs.gnome-clocks

	# Offline password manager with many features.
	pkgs.keepassxc

]; }
