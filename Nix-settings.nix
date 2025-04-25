{ config, ... }: {

	# Which version of NixOS was initially installed on the current system.
	# There is no need to change it post-installation, even when upgrading to a newer NixOS version.
	system.stateVersion = "24.11";

	# Increase the size of the download buffer for Nix.
	nix.settings.download-buffer-size = 524288000;

}
