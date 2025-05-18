{ config, lib, pkgs, ... }: let

	# Bluetooth support; Toggleable in this module.
	bluetooth = config.hardware.bluetooth.enable;

in {

	# Whether to enable support for Bluetooth.
	hardware.bluetooth.enable = true;

	# Whether to activate the Blueman Bluetooth service.
	services.blueman.enable = lib.optionalAttrs bluetooth true;

	# Whether to allow controlling media through Blueetoh headset buttons.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = lib.optionalAttrs bluetooth true;

}
