{ pkgs, ... }: { environment.systemPackages = [

	# A GTK calculator from GNOME.
	pkgs.gnome-calculator

	# A simple and elegant clock application from GNOME.
	pkgs.gnome-clocks

	# Offline password manager with many features.
	pkgs.keepassxc

]; }
