{ config, ... }: {

	boot.loader.systemd-boot = {

		# Menu system that allows booting an OS installer over the network.
		# https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.netbootxyz.enable
		netbootxyz.enable = true;

		# RAM test.
		# https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.memtest86.enable
		memtest86.enable = true;

		# Maximum number of latest NixOS generations in the boot menu.
		# https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.configurationLimit
		configurationLimit = 10;
	};

}
