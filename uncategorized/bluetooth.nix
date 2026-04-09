{ config, lib, ... }: {
	hardware.bluetooth.enable = true;
	services.blueman.enable = lib.mkIf config.hardware.bluetooth.enable true;
}