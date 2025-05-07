{ config, pkgs, ... }: let bluetooth = config.hardware.bluetooth.enable; in {

	# Whether to enable support for ᛒluetooth.
	hardware.bluetooth.enable = true;

	# If Bluetooth is enabled, activate the Blueman service.
	services.blueman.enable = bluetooth;

	# If Bluetooth is enabled, allow controlling media through Bluetooth headset buttons.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = bluetooth;

}
