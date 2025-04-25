{ pkgs, ... }: { environment.systemPackages = [

	# 3D Creation/Animation/Publishing System.
	pkgs.blender

	# 3D pritner / slicing GUI built on top of the Uranium framework.
	pkgs.cura-appimage

]; }
