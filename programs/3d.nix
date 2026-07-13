{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# 3D creation, animation, and publishing system.
		blender

		# Fast and minimalist 3D viewer using VTK.
		# Is used by some thumbnailes to generate thumbnails of 3D files.
#		f3d
	];

	# Temporary applying https://github.com/NixOS/nixpkgs/pull/541146
	nixpkgs.overlays = [(final: prev: {
		pdal = final.callPackage ./pdal/package.nix {};
	})];
}