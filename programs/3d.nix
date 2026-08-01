{ config, pkgs, ... }: let
	# Define which Blender package to install, depending on GPU drivers.
	blenderPkg = if config.hardware.activeGpu == "nvidia-proprietary"
		then pkgs.blender.override { cudaSupport = true; }
		else if config.hardware.activeGpu == "amd" then pkgs.pkgsRocm.blender
		else pkgs.blender;

in {
	environment.systemPackages = with pkgs; [
		# 3D creation, animation, and publishing system.
		blenderPkg

		# Fast and minimalist 3D viewer using VTK.
		# Is used by some thumbnailes to generate thumbnails of 3D files.
		f3d
	];

	# Apply https://github.com/NixOS/nixpkgs/pull/546530
	nixpkgs.overlays = [(final: prev: {
		openshadinglanguage = final.callPackage ../extra-modules/packages/openshadinglanguage/package.nix {};
	})];
}