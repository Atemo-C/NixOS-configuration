{ config, ... }: {

	hardware.bluetooth = {

		# Whether to enable support for Bluetooth.
		# https://search.nixos.org/options?channel=24.05&show=hardware.bluetooth.enable
		enable = true;

		# Whether to power up the default Bluetooth controller on boot.
		# https://search.nixos.org/options?channel=24.05&show=hardware.bluetooth.powerOnBoot
		powerOnBoot = true;
	};

}
