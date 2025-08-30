{ config, lib, pkgs, ... }: {
	# Use the proprietary NVIDIA drivers (16XX and later only).
	services.xserver.videoDrivers = [ "nvidia" ];

	# NVIDIA drivers settings to apply from boot.
	boot.kernelParams = lib.optionals (lib.elem "nvidia" config.services.xserver.videoDrivers) [
		"nvidia.NVreg_EnableResizableBar=1" # Enable reBAR. Thanks to LACT for showing me it was off.
		"nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Make resuming more stable.
		"nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1" # Lower latency during gaming. Remove if causes issues.
		"nvidia.NVreg_UsePageAttributeTable=1" # Fixes poor CPU performances in a lot of cases.
		"nvidia.NVreg_TemporaryFilePath=/var/tmp" # Store temporary files on disk and not on ram (/tmp).
	];

	hardware = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		nvidia = {
			# Whether to enable the open-source NVIDIA kernel modules.
			# It is recommended to disable it on versions prior to the 560 drivers.
			open = true;

			# The driver package to use.
				package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
				version = "575.64.05";
				sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
				sha256_aarch64 = "sha256-GRE9VEEosbY7TL4HPFoyo0Ac5jgBHsZg9sBKJ4BLhsA=";
				openSha256 = "sha256-mcbMVEyRxNyRrohgwWNylu45vIqF+flKHnmt47R//KU=";
				settingsSha256 = "sha256-o2zUnYFUQjHOcCrB0w/4L6xI1hVUXLAWgG2Y26BowBE=";
				persistencedSha256 = "sha256-2g5z7Pu8u2EiAh5givP5Q1Y4zk4Cbb06W37rf768NFU=";
			};
		};

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
		nvidia-container-toolkit.enable = false;
	};

	# Install some CUDA packages.
	environment.systemPackages = lib.optionals config.hardware.nvidia-container-toolkit.enable (with pkgs.cudaPackages; [
		cudnn
		cutensor
	]);
}