# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=nixpkgs.config

# Allow the use of packages from the unstable branch of NixOS by using pkgs.unstable.<package-name>.
{ config, pkgs, ... }:
let NixOS-unstable = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"; in {
	nixpkgs.config = {
		packageOverrides = pkgs: { unstable = import NixOS-unstable { config = config.nixpkgs.config; }; };
	};
}
