{ config, pkgs, ... }: {

	# Allow the use of packages from the unstable branch by using `pkgs.unstable.package-name`.
	# https://search.nixos.org/options?channel=24.05&show=nixpkgs.config
	let
		NixOS-unstable = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
	in {
		nixpkgs.config = {
			packageOverrides = pkgs: {
				unstable = import NixOS-unstable {
					config = config.nixpkgs.config;
				};
			};
		};
	};

}
