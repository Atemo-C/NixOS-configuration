# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for 1TB-SSD.
	fileSystems."/run/media/${config.user.name}/1TB-SSD" = {
		device = "/dev/disk/by-uuid/303f0216-92b5-4a30-9a4b-e1128e9352dd";
		fsType = "btrfs";
		options = [
			"defaults"
			"rw"
			"nofail"
			"users"
			"exec"
			"x-systemd.automount"
			"x-systemd.device-timeout=8"
		];
	};

	# Passwordless decryption via USB key, with password fallback.
	environment.etc.crypttab.text = ''
		2TB-SSD UUID=303f0216-92b5-4a30-9a4b-e1128e9352dd /dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0
	'';

	# Udev rule to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="eui.0025385531b0ddd7",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@1TB-SSD.service"
	'';
}