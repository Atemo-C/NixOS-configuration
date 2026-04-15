{ config, lib, pkgs, ... }: let cfg = config.programs.noctalia-shell; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.noctalia-shell.install = lib.mkEnableOption ''
		Whether to install the Noctalia Shell, a sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell.
	'';

	config = lib.mkIf cfg.install {
		environment.systemPackages = [ pkgs.noctalia-shell ];
		nixpkgs.overlays = [
			(final: prev: {
				noctalia-shell = final.callPackage ./noctalia-shell-temp.nix {};
				noctalia-qs = final.callPackage ./noctalia-qs-temp.nix {};
			})
		];
	};
}