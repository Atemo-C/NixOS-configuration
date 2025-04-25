{ config, pkgs, ... }: { specialisation.NVIDIA = {

	# Whether to inherit the main configuration.
	inheritParentConfig = true;

	# Configuration for the NVIDIA module.
	configuration = {
		# Tag for this specialisation.
		system.nixos.tags = [ "NVIDIA" ];

		# CUDA packages to install, if desired.
		environment.systemPackages = [
			pkgs.cudaPackages.cudnn
			pkgs.cudaPackages.cutensor
		];

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
		hardware.nvidia-container-toolkit.enable = true;

		# Make resuming more stable in some situations with an NVIDIA GPU.
		boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

		hardware.nvidia = {
			# Whether to enable Dynamic Boost.
			# It balances power between the CPU and the GPU for improved peformance on supported laptops.
			dynamicBoost.enable = false;

			# Whether to enable kernel modesetting when using the proprietary NVIDIA driver.
			# Enabling it fixes screen tearing when using Optimus via PRIME.
			# It can also cause Wayland compositors to work when they otherwise wouldn't.
			modesetting.enable = true;

			# Whether to enable the open source NVIDIA kernel module.
			# Should probably be disabled on versions prior to the 560 drivers.
			open = true;

			# The NVIDIA driver package to use.
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable experimental power management through systemd.
			powerManagement.enable = true;
		};

		# Use the proprietary NVIDIA drivers.
		services.xserver.videoDrivers = [ "nvidia" ];

#		# Service to unload NVIDIA modules when using `systemctl kexec`. Work in progress.
#		systemd.services.unmodeset = {
#			description = "Attempt to unload nvidia modesetting modules from the kernel.";
#			documentation = [ "man:modprobe(8)" ];
#			after = [ "umount.target" ];
#			before = [ "kexec.target" ];
#			wantedBy = [ "kexec.target" ];
#			serviceConfig = {
#				Type = "oneshot";
#				ExecStart = "${pkgs.kmod}/bin/modprobe -r nvidia_drm";
#				RemainAfterExit = true;
#			};
#			enable = true;
#		};
	};

}; }
