{ config, ... }: {

	# Version of Home Manager to use. Should match the NixOS version.
	# https://nix-community.github.io/home-manager/options.xhtml#opt-home.stateVersion
	home-manager.users.${config.Custom.Name}.home.stateVersion = "24.05";

}
