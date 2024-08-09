{ config, pkgs, ... }: {

	boot = {
		# NVIDIA GPU kernel module.
		# https://search.nixos.org/options?channel=24.05&show=boot.extraModulePackages
		# https://search.nixos.org/options?channel=24.05&show=boot.initrd.kernelModules
		extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_beta ];
		initrd.kernelModules = [ "nvidia" ];

		# Parameters added to the Kernel command line. Here, used to make suspend work properly.
		# https://search.nixos.org/options?channel=24.05&show=boot.kernelParams
		kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
	};

	# CUDA toolkit.
#	environment.systemPackages = with pkgs; [ cudaPackages.cudatoolkit ];

	hardware = {
		nvidia = {
			# Whether to enable kernel modesetting when using the NVIDIA proprietary driver.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.modesetting.enable
			modesetting.enable = true;

			# Whether to enable `nvidia-settings`, NVIDIA's GUI configuration tool.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.nvidiaSettings
			nvidiaSettings = true;

			# The NVIDIA driver package to use.
			# See Kernel/Version.nix for the Kernel used in this configuraion.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.package
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable power management thorugh systemd.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.powerManagement.enable
			powerManagement.enable = true;

			# NVIDIA PRIME.
#			prime = {
#				# Bus ID of the desired AMD GPU.
#				# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.prime.amdgpuBusId
#				amdgpuBusId = "PCI:42:0:0";
#
#				# Bus ID of the desired Intel GPU.
#				# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.prime.intelBusId
#				intelBusId = "";
#
#				# Bus ID of the desired NVIDIA GPU.
#				# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.prime.nvidiaBusId
#				nvidiaBusId = "PCI:16:0:0";
#
#				offload = {
#					# Whether to enable render offload support for NVIDIA PRIME.
#					# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.prime.offload.enable
#					enable = true;
#
#					# Whether to enable adding a `nvidia-offload` script to offload programs to the NVIDIA GPU.
#					# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.prime.offload.enableOffloadCmd
#					enableOffloadCmd = true;
#				};
#			};
		};

		opengl = {
			# Whether to enable OpenGL drivers.
			# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.enable
			enable = true;

			# Whether to enable accelerated OpenGL rendering through DRI.
			# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport
			driSupport = true;

			# Whether to enable accelerated OpenGL rendering through DRI for 32-bit applications.
			# https://search.nixos.org/options?channel=24.05&show=hardware.opengl.driSupport32Bit
			driSupport32Bit = true;
		};
	};

	# Names of the video drivers to be supported.
	# https://search.nixos.org/options?channel=24.05&show=services.xserver.videoDrivers
	services.xserver.videoDrivers = [
		"nvidia"
#		"nvidialegacy470"
#		"nvidialegacy390"
#		"nvidialegacy340"
	];

}
