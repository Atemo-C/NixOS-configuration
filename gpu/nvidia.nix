{ config, lib, pkgs, ... }: {
	# Use the proprietary NVIDIA drivers for 16XX and later GPUs.
	services.xserver.videoDrivers = [ "nvidia" ];

	# NVIDIA driver settings to apply from boot.
	boot.kernelParams = lib.optionals (lib.elem "nvidia" config.services.xserver.videoDrivers) [
		"nvidia.NVreg_EnableResizableBar=1"                      # Enable reBAR.
		"nvidia.NVreg_PreserveVideoMemoryAllocations=1"          # Make resuming more stable.
		"nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1" # Lower latency during gaming. Remove if causes issues.
		"nvidia.NVreg_UsePageAttributeTable=1"                   # Fixes poor CPU performances in a lot of cases.
		"nvidia.NVreg_TemporaryFilePath=/var/tmp"                # Store temporary files on disk and not on ram (/tmp).
	];

	hardware = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		# Whether to enable the open-source NVIDIA kernel modules (recommended for 560+ drivers).
		nvidia.open = true;

		# The driver package to use.
		nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
			# Stable "Production" drivers (575).
			#version            = "575.64.05";
			#sha256_64bit       = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
			#sha256_aarch64     = "sha256-GRE9VEEosbY7TL4HPFoyo0Ac5jgBHsZg9sBKJ4BLhsA=";
			#openSha256         = "sha256-mcbMVEyRxNyRrohgwWNylu45vIqF+flKHnmt47R//KU=";
			#settingsSha256     = "sha256-o2zUnYFUQjHOcCrB0w/4L6xI1hVUXLAWgG2Y26BowBE=";
			#persistencedSha256 = "sha256-2g5z7Pu8u2EiAh5givP5Q1Y4zk4Cbb06W37rf768NFU=";

			# Latest "production" drivers (580.8X).
			version            = "580.82.09";
			sha256_64bit       = "sha256-Puz4MtouFeDgmsNMKdLHoDgDGC+QRXh6NVysvltWlbc=";
			sha256_aarch64     = "sha256-6tHiAci9iDTKqKrDIjObeFdtrlEwjxOHJpHfX4GMEGQ=";
			openSha256         = "sha256-YB+mQD+oEDIIDa+e8KX1/qOlQvZMNKFrI5z3CoVKUjs=";
			settingsSha256     = "sha256-um53cr2Xo90VhZM1bM2CH4q9b/1W2YOqUcvXPV6uw2s=";
			persistencedSha256 = "sha256-lbYSa97aZ+k0CISoSxOMLyyMX//Zg2Raym6BC4COipU=";

			# Latest "Beta" drivers (580.6X).
			#version = "580.65.06";
			#sha256_64bit = "sha256-BLEIZ69YXnZc+/3POe1fS9ESN1vrqwFy6qGHxqpQJP8=";
			#sha256_aarch64 = "sha256-4CrNwNINSlQapQJr/dsbm0/GvGSuOwT/nLnIknAM+cQ=";
			#openSha256 = "sha256-BKe6LQ1ZSrHUOSoV6UCksUE0+TIa0WcCHZv4lagfIgA=";
			#settingsSha256 = "sha256-9PWmj9qG/Ms8Ol5vLQD3Dlhuw4iaFtVHNC0hSyMCU24=";
			#persistencedSha256 = "sha256-ETRfj2/kPbKYX1NzE0dGr/ulMuzbICIpceXdCRDkAxA=";
		};

		# Whether to enable power management through systemd; Often necessary for stable suspend.
		nvidia.powerManagement.enable = true;

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
		nvidia-container-toolkit.enable = false;
	};

	# CUDA packages.
	environment.systemPackages = lib.optionals config.hardware.nvidia-container-toolkit.enable (with pkgs.cudaPackages; [
		cudnn
		cutensor
	]);
}