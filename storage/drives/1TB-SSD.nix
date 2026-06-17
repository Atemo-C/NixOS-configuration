# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for 1TB-SSD.
	fileSystems."/run/media/${config.user.name}/1TB-SSD" = {
		device = "/dev/disk/by-uuid/7a25b8b8-2421-4c31-8944-4ca844ec5c6a";
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
		1TB-SSD UUID=25d692f5-7e7c-47a2-b7c6-1f32b8b7fe39 /dev/disk/by-id/usb-Generic_Flash_Disk_94A5D05A-0:0 luks,nofail,keyfile-size=4096
	'';

	# Udev rule to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="eui.0025385531b0ddd7",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@1TB-SSD.service"
	'';
}