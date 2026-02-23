{ config, lib, ... }: {
	programs = {
		blender = {
			# Whether to enable Blender, a 3D creation, animation, and publishing system.
			enable = true;

			# Whether to compile Blender with CUDA support.
			# Rebuilding the system will take much longer due to compillation time.
			cudaSupport = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) false;
		};

		# Fast and minimalist 3D viewer using VTK.
		# Can be used by thumbnailers to generate thumbnails of 3D files.
		f3d.install = true;
	};

	# Design and visualize your future home.
	services.flatpak.packages = [ "com.sweethome3d.Sweethome3d" ];
}