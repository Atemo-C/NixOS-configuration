{ config, pkgs, ... }: {

	# Names of supported filesystems type, or an attribute set of file system types and their states.
	# The set form may be used together with lib.mkForce to explicitly disable support for specific filesystems;
	# e.g. to disable ZFS with an unsupported kernel.
	boot.supportedFilesystems = [ "ntfs" ];

	# Packages providing support and tools for additional filesystems.
	# (Gparted will be very happy about that.)
	environment.systemPackages = [
		pkgs.cryptsetup
		pkgs.exfatprogs
		pkgs.f2fs-tools
		pkgs.hfsprogs
		pkgs.jfsutils
		pkgs.lvm2
		pkgs.nilfs-utils
		pkgs.udftools
		pkgs.util-linux
		pkgs.xfsdump
		pkgs.xfsprogs
	];

}
