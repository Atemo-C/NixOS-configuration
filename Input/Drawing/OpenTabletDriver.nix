{ config, ... }: {

	hardware.opentabletdriver = {

		# Whether to start the OpenTabletDriver daemon as a systemd user service.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opentabletdriver.daemon.enable
		daemon.enable = true;

		# Whether to enable the OpenTabletDriver drivers.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opentabletdriver.enable
		enable = true;
	};

}
