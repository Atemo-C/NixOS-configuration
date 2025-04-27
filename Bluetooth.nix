{ config, pkgs, ... }: rec {

	# Enable support for ᛒluetooth.
	hardware.bluetooth.enable = true;

	# Install the Blueberry Bluetooth utility if Bluetooth is enabled.
	environment.systemPackages = [ (if hardware.bluetooth.enable then pkgs.blueberry else null) ];

	# Enable the Blueman Bluetooth manager if Bluetooth is enabled.
	services.blueman.enable = hardware.bluetooth.enable;

	# Allow the user to control media using Bluetooth headset buttons.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = hardware.bluetooth.enable;

}
