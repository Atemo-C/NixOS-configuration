{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# 3D Creation/Animation/Publishing System.
	blender

	# With CUDA support.
#	(blender.override { cudaSupport = true; })

	# 3D pritner / slicing GUI built on top of the Uranium framework.
	cura-appimage

]; }
