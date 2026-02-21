# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for encrypted 500GB HDD.
	fileSystems."/run/media/${config.userName}/Barracuda-500GB-HDD" = {
		device = "/dev/disk/by-uuid/80e367a7-a19f-4008-b2b3-53b12f85eb4a";
		fsType = "btrfs";
		options = [
			"defaults"
			"rw"
			"nofail"
			"users"
			"exec"
			"compress=zstd:3"
			"x-systemd.automount"
			"x-systemd.device-timeout=8"
		];
	};

	# Non-essential encrypted drive (boot will not fail if these are not present).
	environment.etc.crypttab.text = ''
		Barracuda-500GB-HDD UUID=abdb06a5-c449-4d12-a670-a14d1021d7ed /etc/nixos/storage/keys/barracuda-500gb-hdd.key luks,nofail
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="0x5000c50027e4ac34",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@Barracuda-500GB-HDD.service"
	'';
}