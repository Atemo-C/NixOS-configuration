{ config, lib, pkgs, ... }: lib.mkIf config.programs.niri.enable {
	environment.systemPackages = with pkgs; [
		blender       # 3D creation, animation, publishing system.
		cura-appimage # 3D printer slicing utility.

		# Disign and visualize your future home (version before it sucked).
		# Warning: For some reason, installing it breaks Flatpaks???
		# https://github.com/NixOS/nixpkgs/issues/365726
		#sweethome3d.application

		# Easily create SH3T files and edit the properties of the texture images it contains.
		#sweethome3d.textures-editor

		# Quickly create SH3F files and edit the properties of the 3D models it contains.
		#sweethome3d.furniture-editor
	];

	# CUDA for Blender when available.
	nixpkgs.config = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		packageOverrides = self : rec { blender = self.blender.override { cudaSupport = true; }; };
	};
}