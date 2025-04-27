{ config, pkgs, ... }: { specialisation.NVIDIA.configuration = {

	# Tag for this specialisation, seen at boot.
	system.nixos.tags = [ "NVIDIA" ];

	# If desired, CUDA packages to install.
	environment.systemPackages = [
		pkgs.cudaPackages.cudnn
		pkgs.cudaPackages.cutensor
	];

	# Make resuming more stable in some situations with an NVIDIA GPU.
	boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

	hardware = {
		nvidia = {
			# Whether to enable the open source NVIDIA kernel module.
			# Should probably be disabled on versions prior to the 560 drivers.
			open = true;

			# The NVIDIA driver package to use.
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable experimental power management through systemd.
			powerManagement.enable = true;
		};

		# Enable dynamic CDI configuration for NVIDIA GPUs.
		nvidia-container-toolkit.enable = true;
	};

	# Use the proprietary NVIDIA drivers.
	services.xserver.videoDrivers = [ "nvidia" ];
}; }
