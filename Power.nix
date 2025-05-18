{ config, pkgs, ... }: {

	# Whether to enable the Upower DBus service.
	# It provides power management support to applications.
	services.upower.enable = true;

	# Power-related utilities.
	environment.systemPackages = [
		# Read & control device brightness.
		pkgs.brightnessctl

		# Small collection of scripts that handle suspend & resume of behalf of HAL.
		# Here in case `systemctl suspend` does not work, such as computers like Lenovo's ThinkPad L510.
		pkgs.pmutils
	];

}
