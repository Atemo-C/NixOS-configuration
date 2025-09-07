{ config, ... }: {
	# Which version of NixOS was initially installed on the current system.
	# There is no need to change it post-installation, even when upgrading to a newer NixOS version.
	# Only change it if you are fully re-installing with a different version.
	system.stateVersion = "25.11";

	# Whether to save disk space by hard-linking files in the store that have identical contents.
	nix.settings.auto-optimise-store = true;

	# Increase the size of the download buffer for Nix.
	nix.settings.download-buffer-size = 629145600;

	# Enable the nix-command feature.
	nix.settings.experimental-features = [ "nix-command" ];

	# Make the `/etc/nixos/` directory and its files owned by the user.
	systemd.tmpfiles.rules = [ "Z /etc/nixos 0755 ${config.userName} users - -"];
}