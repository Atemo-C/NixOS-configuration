{ config, ... }: {

	# Wether to enable the systemd-boot EFI boot manager.
	# https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.enable
	boot.loader.systemd-boot.enable = true;

}
