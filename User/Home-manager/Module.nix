{ config, pkgs, ... }:

# Adds Home Manager. Its version can be configured in User/Home-manager/Settings.nix
# https://wiki.nixos.org/wiki/Home_manager#Usage_as_a_NixOS_module
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
	imports = [ "${home-manager}/nixos" ];
}
