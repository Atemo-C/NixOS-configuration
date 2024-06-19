{ config, pkgs, ... }:

# Adds Home Manager. Its version should match the installed NixOS version.
# https://wiki.nixos.org/wiki/Home_manager#Usage_as_a_NixOS_module
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in {
	imports = [ "${home-manager}/nixos" ];

	home-manager.users.${config.Custom.Name}.home.stateVersion = "24.05";
}
