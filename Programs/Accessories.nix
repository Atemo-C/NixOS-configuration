{ pkgs, ... }: { environment.systemPackages = [

	# A simple and elegant clock application from GNOME.
	pkgs.gnome-clocks

	# Fully-featured minimalist configurable calculator.
	pkgs.mini-calc

	# Offline password manager with many features.
	pkgs.keepassxc

]; }
