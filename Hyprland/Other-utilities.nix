{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# GNOME's clock program.
		gnome.gnome-clock

		# Calculator.
		galculator

		# Password manager.
		unstable.keepassxc
	];

}
