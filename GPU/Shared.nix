{ config, pkgs, ... }: {

	hardware.graphics = rec {
		# Whether to enable hardware accelerated graphics drivers.
		enable = true;

		# Also install 32-bit drivers for 32-bit applications.
		enable32Bit = enable;

		# Extra packages for hardware acceleration.
		# There should be little to no conflicts with multiple of them installed.
		extraPackages = [
			pkgs.intel-media-driver    # VA-API for modern Intel GPUs.
			pkgs.intel-vaapi-driver    # VA-API for older Intel GPUs using the i965 driver.
			pkgs.intel-compute-runtime # OpenCL for Intel GPUs.
			pkgs.rocmPackages.clr.icd  # OpenCL for AMD GPUs.
		];
	};

}
