{ config, lib, ... }: {
	hardware = {
		# Which of the major GPU brands is used.
		# This is used to guide which variant of packages should be installed.
		# Can be one of `default` (intel & co), `amd`, or `nvidia-proprietary`.
		activeGpu = "amd";

		amdgpu = lib.mkIf (config.hardware.activeGpu == "amd") {
			# Allow the AMD GPU drivers to be loaded properly as early as possible.
			initrd.enable = true;

			# Whether to enable OpenCL support using the ROCM runtime library.
			opencl.enable = true;

			# Whether to enable `amdgpu` overdrive mode for overclocking.
			overdrive.enable = lib.mkIf config.services.lact.enable true;
		};
	};

	# Whether to enable LACT, a tool for monitoring, configuring, and overclocking GPUs.
	services.lact.enable = true;
}
