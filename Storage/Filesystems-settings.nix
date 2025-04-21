{ config, ... }: { services = {

	# Whether to enable periodic scrubbing on BTRFS.
	btrfs.autoScrub.enable = true;

	# Whether to enable periodic SSD TRIM.
	# May not be necessarry on filesystems with a similar function enabled.
	fstrim.enable = false;

	# smartd options for specific drives.
#	smartd.devices = [
#		{
#			# Prevent smartd from waking up this drive during standby.
#			device = "/dev/disk/by-id/ata-ST3500418AS_5VMETGG9";
#			options = "-n standby";
#		}
#		{
#			# Prevent smartd from waking up this drives during standby.
#			device = "/dev/disk/by-id/ata-WDC_WD1600BEVS-08VAT2_WD-WXP1A30R8683";
#			options = "-n standby";
#		}
#		{
#			# Prevent smartd from waking up this drive during standby.
#			device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_448164BNS";
#			options = "-n standby";
#		}
#	];

}; }
