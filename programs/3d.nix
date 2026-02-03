{ config, lib, ... }: { programs = {
	blender = {
		# Whether to enable Blender, a 3D creation, animation, and publishing system.
		enable = true;

		# Whether to compile Blender with CUDA support.
		# Rebuilding the system could take longer due to potential compillation.
		cudaSupport = lib.mkIf (lib.elem "nvidia" config.services.xserevr.videoDrivers) true;
	};

	# Fast and minimalist 3D viewer using VTK.
	# Can be used by thumbnailers to generate thumbnails of 3D files.
	f3d.install = true;
}; }