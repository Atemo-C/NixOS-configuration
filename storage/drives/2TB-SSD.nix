# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for 2TB-SSD SSD.
	fileSystems."/run/media/${config.user.name}/2TB-SSD" = {
		device = "/dev/disk/by-uuid/7aff4eb7-604e-4997-8480-4dcaa1b14541";
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

	# Non-essential encrypted drive (boot will not fail if these are not present).
	environment.etc.crypttab.text = ''
		2TB-SSD UUID=7c69b946-b6e2-4b97-8416-6a86d66dfb60 ${config.users.users.${config.user.name}.home}/Other/Mounts/2TB-SSD.key luks,nofail
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="eui.00a07501e9c132dc",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@2TB-SSD.service"
	'';
}