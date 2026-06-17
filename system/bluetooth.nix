{ config, lib, ... }: {
	# Whether to enable support for Bluetooth.
	hardware.bluetooth.enable = true;

	# Whether to enable the blueman Bluetooth manager.
	services.blueman.enable = lib.mkIf config.hardware.bluetooth.enable true;
}