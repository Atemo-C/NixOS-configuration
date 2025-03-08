{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# GTK algebraic and RPN calculator.
	galculator

	# A simple and elegant clock application from GNOME.
	gnome-clocks

	# Offline password manager with many features.
	keepassxc

]; }
