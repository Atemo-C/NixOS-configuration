# https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html
# https://github.com/NixOS/nixpkgs/issues/74281
# Thank you!
{ config, ... }: {
	# Mount for encrypted PS4 HDD.
	fileSystems."/run/media/${config.user.name}/PS4-HDD" = {
		device = "/dev/disk/by-uuid/75d66153-2f9b-4269-84c6-c97e63a36754";
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
		PS4-HDD UUID=303f0216-92b5-4a30-9a4b-e1128e9352dd ${config.users.users.${config.user.name}.home}/Mounts/PS4-hdd.key luks,nofail
	'';

	# Udev rules to unlock the encrypted drive when detected.
	services.udev.extraRules = ''
		SUBSYSTEM=="block" ENV{ID_WWN}=="0x5000cca8aaf04ee6",\
		ENV{SYSTEMD_WANTS}="systemd-cryptsetup@PS4-HDD.service"
	'';
}