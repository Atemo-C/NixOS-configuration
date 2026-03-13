{ config, lib, pkgs, ... }: let cfg = config.programs.noctalia-shell; in {
	meta.maintainers = [ lib.maintainers.atemo-c ];

	options.programs.noctalia-shell.install = lib.mkEnableOption ''
		Whether to install the Noctalia Shell, a sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell.
	'';

	config = lib.mkIf cfg.install {
		environment.systemPackages = [ pkgs.noctalia-shell ];

		# Temporarily apply PR.
		# https://github.com/NixOS/nixpkgs/pull/495434
		nixpkgs.overlays = [
			(final: prev: {
				noctalia-qs = final.callPackage ../../external/pull-requests/noctalia-shell/pkgs/by-name/no/noctalia-qs/package.nix {};
				noctalia-shell = final.callPackage ../../external/pull-requests/noctalia-shell/pkgs/by-name/no/noctalia-shell/package.nix {};
			})
		];
	};
}