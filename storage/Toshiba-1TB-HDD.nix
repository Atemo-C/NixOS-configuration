# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for encrypted 1TB HDD.
	fileSystems."/run/media/${config.userName}/Toshiba-1TB-HDD" = {
		device = "/dev/disk/by-uuid/692420d5-37b0-4b6c-9684-b037e560231b";
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
		Toshiba-1TB-HDD UUID=a862bcd8-b129-411e-9d04-fe5c930bf4ee /etc/nixos/storage/keys/toshiba-1tb-hdd.key luks,nofail
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="0x5000039ffbc08b6c",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@Toshiba-1TB-HDD.service"
	'';
}