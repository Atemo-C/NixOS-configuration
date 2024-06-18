{ config, pkgs, ... }: {

	hardware.opengl = {
		# Whether to enable OpenGL drivers.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.enable
		enable = true;

		# Additional packages to add to OpenGL drivers. This is for OpenCL and VA-API.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.extraPackages
		extraPackages = with pkgs; [

			# OpenCL support.
			intel-compute-runtime

			# Mesa driver for VA-API for Broadwell or newer processors. (iHD)
			intel-media-driver

			# VA-API driver for older processors. (i965)
#			intel-vaapi-driver
		];

		# Additional packages to add to 32-bit OpenGL drivers. This is for VA-API.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.extraPackages32
		extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];

		# Whether to enable accelerated OpenGL rendering through DRI.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport
		driSupport = true;

		# Whether to enable accelerated OpenGL rendering through DRI for 32-bit applications.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport32Bit
		driSupport32Bit = true;
	};

	# Environment variables. This is to define which VA-API driver should be used.
	# https://search.nixos.org/options?channel=24.05&show=environment.sesionVariables
	environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
#	environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; };

	# Names of the video drivers to be supported.
	# https://search.nixos.org/options?channel=24.05&show=services.xserver.videoDrivers
	services.xserver.videoDrivers = [ "modesetting" ];
