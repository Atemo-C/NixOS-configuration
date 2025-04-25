{ pkgs, ... }: { environment.systemPackages =  [

	# GTK algebraic and RPN calculator.
	pkgs.galculator

	# Offline password manager with many features.
	pkgs.keepassxc

]; }
