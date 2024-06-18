{ config, pkgs, ... }: {

	# AMD GPU kernel module.
	# https://search.nixos.org/options?channel=24.05&show=boot.initrd.kernelModules
	boot.initrd.kernelModules = [ "amd" ];

	hardware.opengl = {
		# Whether to enable OpenGL drivers.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.enable
		enable = true;

		# Additional packages to add to OpenGL drivers. This is for AMD's ROCM.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.extraPackages
		extraPackages = with pkgs; [ rocmPackages.clr ];

		# Whether to enable accelerated OpenGL rendering through DRI.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport
		driSupport = true;

		# Whether to enable accelerated OpenGL rendering through DRI for 32-bit applications.
		# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport32Bit
		driSupport32Bit = true;
	};

	# Names of the video drivers to be supported.
	# https://search.nixos.org/options?channel=24.05&show=services.xserver.videoDrivers
	services.xserver.videoDrivers = [ "amdgpu" ];

}
