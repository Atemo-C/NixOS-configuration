{ config, lib, ... }: {
	# Whether to enable support for Bluetooth.
	hardware.bluetooth.enable = true;

	# Whether to activate the Blueman Bluetooth service.
	services.blueman.enable = lib.mkIf (config.hardware.bluetooth.enable && config.programs.niri.enable) true;

	# Whether to allow controlling media through Bluetooth headset buttons.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = lib.mkIf config.hardware.bluetooth.enable true;
}