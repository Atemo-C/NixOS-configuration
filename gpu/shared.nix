{ config, lib, pkgs, ... }: { hardware.graphics = {
	# Whether to enable hardware accelerated graphics drivers.
	enable = true;

	# Whether to also install 32-bit drivers for 32-bit programs.
	enable32Bit = true;

	# Extra packages for hardware acceleration.
	# There should be little to no conflicts when some/all are installed at once.
	# Still, it is recommended to instead configure this in your device's `settings.nix` module.
	extraPackages = lib.optionals config.hardware.graphics.enable (with pkgs; [
#		intel-media-driver    # VA-API for modern Intel GPUs.
#		intel-vaapi-driver    # VA-API for older Intel GPUs using the i965 driver.
#		intel-compute-runtime # OpenCL driver for Intel GPUs.
#		rocmPackages.clr.icd  # OpenCL driver for AMD GPUs.
	]);
}; }