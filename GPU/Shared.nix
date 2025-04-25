{ config, pkgs, ... }: {

	hardware.graphics = {
		# Whether to enable hardware accelerated graphics drivers.
		enable = true;

		# Whether to also install 32-bit drivers for 32-bit applications.
		enable32Bit = true;

		# Extra packages for hardware acceleration.
		# There should be little to no conflicts even with multiple of them installed.
		extraPackages = [
			pkgs.intel-media-driver    # VA-API for modern Intel GPUs.
			pkgs.intel-vaapi-driver    # VA-API for older Intel GPUs using the i965 driver.
			pkgs.intel-compute-runtime # OpenCL for Intel GPUs.
			pkgs.rocmPackages.clr.icd  # OpenCL for AMD GPUs.
		];
	};

}
