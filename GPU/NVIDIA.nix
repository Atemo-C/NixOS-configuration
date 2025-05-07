{ config, pkgs, ... }: {

	# If desired, CUDA packages to install.
#	environment.systemPackages = [
#		pkgs.cudaPackages.cudnn
#		pkgs.cudaPackages.cutensor
#	];

	# Make resuming more stable with NVIDIA GPUs.
	boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

	hardware = {
		nvidia = {
			# Whether to enable the open source NVIDIA kernel module.
			# It is recommended to disable it on versions prior to the 560 drivers.
			open = true;

			# The NVIDIA driver package to use.
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable experimental power management through systemd.
			powerManagement.enable = true;
		};

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
#		nvidia-container-toolkit.enable = true;
	};

	# Use the appropriate NVIDIA drivers.
	services.xserver.videoDrivers = [ "nvidia" ];

}
