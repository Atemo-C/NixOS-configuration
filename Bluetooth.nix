{ config, pkgs, ... }: rec {

	# Whether to enable support for ᛒluetooth.
	hardware.bluetooth.enable = true;

	# ᛒluetooth configuration tool.
	environment.systemPackages = [ (if hardware.bluetooth.enable then pkgs.blueberry else null) ];

	# Whether to enable Blueman, a ᛒluetooth manager.
	services.blueman.enable = hardware.bluetooth.enable;

	# Whether to allow using ᛒluetooth headset buttons to control media for the user.
	home-manager.users.${config.userName}.services.mpris-proxy.enable = hardware.bluetooth.enable;

}
