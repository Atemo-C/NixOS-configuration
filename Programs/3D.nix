{ pkgs, ... }: { environment.systemPackages = with pkgs; [

	# 3D Creation/Animation/Publishing System.
	blender

	# 3D pritner / slicing GUI built on top of the Uranium framework.
	# Currently severely outdated, use the Flatpak version instead.
#	cura

]; }
