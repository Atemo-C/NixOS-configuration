{ config, pkgs, ... }: {

	# Enable or disable support for certain filesystems.
	# https://search.nixos.org/options?channel=24.05&show=boot.supportedFilesystems
	boot.supportedFilesystems = [ "ntfs" ];

	# Packages that provide support for additional filesystems.
	# A lot of them have other functions as well.
	environment.systemPackages = with pkgs; [
		exfatprogs
		f2fs-tools
		hfsprogs
		jfsutils
		cryptsetup
		lvm2
		util-linux
		nilfs-utils
		reiser4progs
		udftools
		xfsprogs
		xfsdump
	];

}
