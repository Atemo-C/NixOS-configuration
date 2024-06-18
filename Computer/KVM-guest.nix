{ config, ... }: {

	# Whether to enable the qemu guest agent.
	# https://search.nixos.org/options?channel=24.05&show=services.qemuGuest.enable
	services.qemuGuest.enable = true;

}
