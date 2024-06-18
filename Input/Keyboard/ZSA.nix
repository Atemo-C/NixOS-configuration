{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# GUI flashing utility for ZSA keyboards.
		keymapp

		# CLI flashing utility for ZSA keyboards.
		wally-cli
	];

	# Whether to make flashing and others available for ZSA keyboards.
	# # https://search.nixos.org/options?channel=24.05&show=hardware.keyboard.zsa.enable
	hardware.keyboard.zsa.enable = true;

}
