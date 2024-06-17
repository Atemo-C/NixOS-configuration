{ config, pkgs, ... }: {

	# Nouveau kernel module.
	# https://search.nixos.org/options?channel=24.05&show=boot.initrd.kernelModules
	boot.initrd.kernelModules = [ "nouveau" ];

	hardware.opengl = {

		# Whether to enable OpenGL drivers.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.enable
		enable = true;

		# Whether to enable accelerated OpenGL rendering through DRI.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport
		driSupport = true;

		# Whether to enable accelerated OpenGL rendering through DRI for 32-bit applications.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport32Bit
		driSupport32Bit = true;
	};

	# Names of the video drivers to be supported.
	# https://search.nixos.org/options?channel=24.05&show=services.xserver.videoDrivers
	services.xserver.videoDrivers = [ "nouveau" ];

}
