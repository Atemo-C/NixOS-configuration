{ config, ... }: {
	# Additional drives to mount.
	imports = [
		./drives/160GB-HDD.nix
		./drives/PS4-HDD.nix
#		./drives/2TB-SSD.nix
	];

	# Set the correct permissions for local encryption keys,
	# only for the above non-essential drives.
	systemd.tmpfiles.rules = [ "Z ${config.users.users.${config.user.name}.home}/Other/Mounts/*.key 0600 root root - -" ];
}