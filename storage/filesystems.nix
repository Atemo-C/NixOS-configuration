{ config, lib, pkgs, ... }: let
	# List of hard disk drives that should not be awakened by smartd during standby.
	spinningrust = [
		"/dev/disk/by-id/ata-ata-ST3500418AS_5VMETGG9"
		"/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_448164BNS"
		"/dev/disk/by-id/ata-WD10SPZX-22Z10T1_WD-WX11A49DKLYU"
		"/dev/disk/by-id/wwn-0x5000039ffbc08b6c"
	];

in {
	# Names of supported filesystem type, or an attribute set of file system types and their states.
	# The set form may be used together with `lib.mkForce` to explicitly disable support for specific filesystems;
	# e.g. to disable ZFS with an unsupported kernel.
	boot.supportedFilesystems = [ "ntfs" ];

	# Packages providing support and tools for additional filesystems.
	# (Gparted will be very happy about that.)
	environment.systemPackages = with pkgs; [
		cryptsetup
		exfatprogs
		f2fs-tools
		hfsprogs
		jfsutils
		lvm2
		nilfs-utils
		udftools
		util-linux
		xfsdump
		xfsprogs
	];

	services = rec {
		# Whether to enable periodic scrubbing on BTRFS.
		btrfs.autoScrub.enable = true;

		# Whether to enable periodic SSD TRIM.
		# May not be necessary on filesystems with a similar function enabled.
		fstrim.enable = lib.mkIf btrfs.autoScrub.enable false;

		# Whether to enable GVFs, a userspace virtual filesystem.
		gvfs.enable = true;

		smartd = {
			# Whether to enable the smartd daemon from the smartmontools package.
			enable = true;

			# Configure smartd to not wake up hard disk drives during standby.
			devices = map (device: {
				inherit device;
				options = "-n standby -d removable";
			}) spinningrust;
		};

		# Whether to enable the udisks2 DBus service, allowing programs to query and manipulate storage devices.
		udisks2.enable = true;
	};
}