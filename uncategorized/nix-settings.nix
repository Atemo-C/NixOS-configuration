{ config, ... }: {
	# Which version of NixOS was initially installed on the current system.
	# There is no need to change it post-installation, even when upgrading to a newer NixOS version.
	# Only change it if you are fully re-installing with a different version.
	system.stateVersion = "25.11";

	nix.settings = {
		# Whether to save disk space by hard-linking files in the store that have identical contents.
		auto-optimise-store = true;

		# Increase the size of the download buffer for Nix.
		download-buffer-size = 629145600;

		# Enable the nix-command feature.
		experimental-features = [ "nix-command" ];
	};
}