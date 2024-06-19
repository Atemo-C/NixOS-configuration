{ config, pkgs, ... }: {

	# ST terminal emulator.
	environment.systemPackages = with pkgs; [ st ];

	# Patching ST with a local package.
#	nixpkgs.overlays = with pkgs; [
#		(final: prev: {
#			st = prev.st.overrideAttrs (
#				old: { src = /etc/nixos/ST ; }
#			);
#		})
#	];

}
