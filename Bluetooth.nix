{ config, pkgs, ... }: rec {

	# Whether to enable support for Bluetooth.
	hardware.bluetooth.enable = true;

	# If Bluetooth is enabled, add a Bluetooth configuration tool.
	environment.systemPackages = [( if hardware.bluetooth.enable then pkgs.blueberry else null )];

	# If Bluetooth is enabled, enable the Blueman Bluetooth manager.
	services.blueman.enable = hardware.bluetooth.enable;

	# If Bluetooth is enabled, allow using Bluetooth headset buttons to control media for the user.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = hardware.bluetooth.enable;

}
