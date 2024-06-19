{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# GNOME's clock program.
		gnome.gnome-clocks

		# Calculator.
		galculator

		# Password manager.
		unstable.keepassxc
	];

}
