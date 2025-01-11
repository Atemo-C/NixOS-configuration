# Allows the use of packages from the unstable branch of NixOS by using pkgs.unstable.<package-name>.
{ config, pkgs, ... }: let NixOS-unstable = builtins.fetchTarball
"https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
in {
	nixpkgs.config.packageOverrides = pkgs: {
		unstable = import NixOS-unstable { config = config.nixpkgs.config; };
	};
}
