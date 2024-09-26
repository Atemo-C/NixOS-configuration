# Used NixOS packages:
#─────────────────────
# • [blender]
#   https://www.blender.org/
#
# • [cura]
#   https://github.com/Ultimaker/Cura

{ pkgs, ... }: { environment.systemPackages = [

	# 3D Creation/Animation/Publishing System.
	pkgs.blender

	# 3D pritner / slicing GUI built on top of the Uranium framework.
	# pkgs.unstable.cura # Currently, use the Flatpak instead.

]; }
