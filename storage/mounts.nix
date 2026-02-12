{ config, ... }: {
#	fileSystems = {
#		# Mount for 1TB Toshiba DT01ACA100 7200RPM HDD.
#		"/run/media/${config.userName}/1TB-GPT-TOSHIBA" = {
#			device  = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_448164BNS-part1";
#			fsType  = "btrfs";
#			options = [ "defaults" "rw" "nofail" "users" "exec" ];
#		};
#	};

	# Import more advanced mount options for specific storage devices.
	imports = [
		./160GB-HDD.nix
		./Toshiba-1TB-HDD
	];
}