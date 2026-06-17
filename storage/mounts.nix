{ config, ... }: {
	# Additional drives to mount across all systems.
	# Device-specific mounts are to be define in the devices' `settings.nix` module.
	imports = [];

	# Set the correct permissions for local encryption keys, if desired.
	systemd.tmpfiles.rules = [ "Z ${config.users.users.${config.user.name}.home}/Other/Mounts/*.key 0600 root root - -" ];
}