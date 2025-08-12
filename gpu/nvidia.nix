{ config, lib, pkgs, ... }: rec {
	# Use the proprietary NVIDIA drivers (16XX and later only).
	services.xserver.videoDrivers = [ "nvidia" ];

	# Make resuming more stable.
	boot.kernelParams = lib.optional lib.elem "nvidia" config.services.xserver.videoDrivers
		"nvidia.NVreg_PreserveVideoMemoryAllocations=1";

	hardware = lib.mkIf lib.elem "nvidia" services.xserver.videoDrivers {
		nvidia = {
			# Whether to enable the open-source NVIDIA kernel modules.
			# It is recommended to disable it on versions prior to the 560 drivers.
			open = true;

			# The driver package to use.
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable experimental power management through systemd.
			powerManagement.enable = true;
		};

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
		nvidia-container-toolkit.enable = false;
	};

	# Install some CUDA packages.
	environment.systemPackages = lib.optionals hardware.nvidia-container-toolkit.enable (with pkgs.cudaPackages; [
		cudnn
		cutensor
	]);
}