{ config, ... }: {

	# Enable or disable support for certain filesystems.
	# https://search.nixos.org/options?channel=24.05&show=boot.supportedFilesystems
	boot.supportedFilesystems = [ "ntfs" ];

}
