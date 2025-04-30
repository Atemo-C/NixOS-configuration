{ config, pkgs, ... }: let Bluetooth = config.hardware.bluetooth.enable; in {

	# Whether to enable support for ᛒluetooth.
	hardware.bluetooth.enable = true;

	# Install the Blueberry Bluetooth utility if Bluetooth is enabled.
	environment.systemPackages = if Bluetooth then [ pkgs.blueberry ] else [];

	# Enable the Blueman Bluetooth manager if Bluetooth is enabled.
	services.blueman.enable = Bluetooth;

	# Allow the user to control media using Bluetooth headset buttons if Bluetooth is enabled.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = Bluetooth;

}
