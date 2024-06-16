{ config, ... }: {

	# Timeout in seconds until the system boots the default menu item.
	# https://search.nixos.org/options?channel=24.05&show=boot.loader.timeout
	boot.loader.timeout = 0;

}
