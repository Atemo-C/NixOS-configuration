{ config, ... }: {

	# Wether the installation process is allowed to modify EFI boot variables.
	# https://search.nixos.org/options?channel=24.05&show=boot.loader.efi.canTouchEfiVariables
	boot.loader.efi.canTouchEfiVariables = true;

}
