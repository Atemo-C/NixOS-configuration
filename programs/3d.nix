{ config, lib, ... }: { programs = {
	blender = {
		# Whether to install Blender, a 3D creation, animation, and publishing system.
		enable = true;

		# Whether to compile Blender with CUDA support.
		# This would make NixOS rebuilds take a LONG time when Blender has to be built,
		# however, the CUDA binary cache is enabled, and it *should* solve this issue.
		cudaSupport = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) true;
	};

	# G-code geerator for 3D printers.
	orca-slicer.enable = true;
}; }