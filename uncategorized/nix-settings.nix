{ config, ... }: {
	# Which version of NixOS was initially installed on the current system.
	# There is no need to change it post-installation, even when upgrading to a newer NixOS version.
	# Only change it if you are fully re-installing with a different version.
	system.stateVersion = "26.05";

	nix.settings = {
		# Whether to hard-link files in the store that have identical contents.
		# This helps save disk space.
		auto-optimise-store = true;

		# Increase the size of the download buffer for Nix.
		download-buffer-size = 629145600;

		# Enable the nix-command feature.
		experimental-features = [ "nix-command" ];
	};

	# Make the `/etc/nixos/` directory and its files owned by the user.
	# This is for easier editing; Remove if this is a security concern for you.
	# Note that some scripts and other functionaly of this configuration relies on
	# this staying as it is; It will be up to you to adapt them.
	systemd.tmpfiles.rules = [ "Z /etc/nixos 0755 ${config.userName} users - -"];
}