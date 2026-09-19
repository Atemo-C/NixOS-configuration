# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for 160GB-HDD.
	fileSystems."/run/media/${config.user.name}/160GB-HDD" = {
		device = "/dev/disk/by-uuid/b8f90684-4d55-4166-865b-dec7c50c775f";
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

	# Passwordless decryption via USB key, with password fallback.
	environment.etc.crypttab.text = ''
		160GB-HDD UUID=9574ec1c-2e52-4fc4-bdfd-60335c3a8ae5 /dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0 luks,nofail,keyfile-size=4096
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="0x50014ee204651c65",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@160GB-HDD.service"
	'';
}