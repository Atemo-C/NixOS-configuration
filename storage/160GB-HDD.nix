# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for encrypted 160GB HDD.
	fileSystems."/run/media/${config.userName}/160GB-HDD" = {
		device = "/dev/disk/by-uuid/b8f90684-4d55-4166-865b-dec7c50c775f";
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
		160GB-HDD UUID=9574ec1c-2e52-4fc4-bdfd-60335c3a8ae5 none luks,nofail,noauto
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="0x50014ee204651c65",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@160GB-HDD.service"
	'';
}