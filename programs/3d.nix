{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		# 3D creation, animation, publishing system.
		blender

		# 3D printer slicing utility.
		cura-appimage

		# Disign and visualize your future home (version before it sucked).
		# Warning: For some reason, installing it breaks Flatpaks???
		# https://github.com/NixOS/nixpkgs/issues/365726
		#sweethome3d.application

		# Easily create SH3T files and edit the properties of the texture images it contains.
		#sweethome3d.textures-editor

		# Quickly create SH3F files and edit the properties of the 3D models it contains.
		#sweethome3d.furniture-editor
	]);
}