# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for encrypted 1TB HDD.
	fileSystems."/run/media/${config.userName}/Toshiba-1TB-HDD" = {
		device = "/dev/disk/by-uuid/3927d66d-0fb7-46f5-9aa9-e6363be5dfae";
		fsType = "btrfs";
		options = [
			"defaults"
			"rw"
			"nofail"
			"noauto"
			"users"
			"exec"
			"compress=zstd:3"
			"x-systemd.automount"
			"x-systemd.device-timeout=8"
		];
	};

	# Non-essential encrypted drive (boot will not fail if these are not present).
	environment.etc.crypttab.text = ''
		Toshiba-1TB-HDD /dev/disk/by-uuid/3927d66d-0fb7-46f5-9aa9-e6363be5dfae none luks,nofail,noauto
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="0x5000039ffbc08b6c",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@Toshiba-1TB-HDD.service"
	'';
}