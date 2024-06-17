{ config, ... }: {

	# Enable setting virtual console options (such as colors) as early as possible (in initrd).
	# https://search.nixos.org/options?channel=24.05&show=console.earlySetup
	console.earlySetup = true;

}
