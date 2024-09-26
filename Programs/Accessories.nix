# Used NixOS packages:
#─────────────────────
# • [galculator]
#   http://galculator.sourceforge.net/
#
# • [gnome-clocks]
#   https://apps.gnome.org/Clocks/
#
# • [keepassxc]
#   https://keepassxc.org/

{ pkgs, ... }: { environment.systemPackages = [

	# A GTK 2/3 algebraic and RPN calculator.
	pkgs.galculator

	# A simple and elegant clock application for GNOME.
	pkgs.gnome.gnome-clocks

	# Offline password manager with many features.
	pkgs.unstable.keepassxc

]; }
