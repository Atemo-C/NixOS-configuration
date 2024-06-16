{ config, ... }: {

	# Whether to allow editing the kernel command-line before boot.
	# https://search.nixos.org/options?channel=24.05&show=boot.loader.systemd-boot.editor
	boot.loader.systemd-boot.editor = false;

}
