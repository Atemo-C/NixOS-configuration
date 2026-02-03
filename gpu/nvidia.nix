{ config, lib, ... }: {
	# Use the proprietary NVIDIA drivers for 165X and later GPUs.
	services.xserver.videoDrivers = [ "nvidia" ];

	# NVIDIA driver settings to apply from boot.
	boot.kernelParams = [
		# Enable resizable BAR support.
		"nvidia.NVreg_EnableResizableBar=1"

		# Skip over zeroing graphics memory buffers at alloc time.
		# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/nvidia.conf#L20
		"nvidia.NVreg_IntitializeSystemMemoryAllocations=0"

		# Make resuming more stable.
		"nvidia.NVreg_PreserveVideoMemoryAllocations=1"

		# Lower latency when gaming; Could potentially cause some issues.
		"nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1"

		# Fixes poor CPU performances in some cases.
		"nvidia.NVreg_UsePageAttributeTable=1"
	];

	hardware = {
		nvidia = {
			# Whether to enable the open-source NVIDIA kernel modules (recommended for 560+ drivers).
			open = true;

			# Whether to enable power management through systemd; Often necessary for stable suspend.
			powerManagement.enable = true;
		};

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
		nvidia-container-toolkit.enable = false;
	};

	# CUDA packages to install.
	programs.cuda = lib.mkIf config.hardware.nvidia-container-toolkit.enable {
		cudnn.install = true;
		cutensor.install = true;
		cudatoolkit.install = true;
	};

	# Apply some extra udev rules for NVIDIA GPUs (165X and later).
	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/udev/rules.d/71-nvidia.rules
	services.udev.extraRules = ''
		ACTION=="add|bind", SUBSYSTEM=="pci", DRIVERS=="nvidia", \
			ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
			TEST=="power/control", ATTR{power/control}="auto"

		ACTION=="remove|unbind", SUBSYSTEM=="pci", DRIVERS=="nvidia", \
			ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
			TEST=="power/control", ATTR{power/control}="on"
	'';

	# Add the CUDA binary cache to avoid having to rebuild from source too often.
	# There can be some edge cases where this is not ideal.
	# https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
	nix.settings = {
		substituters = [ "https://cache.nixos-cuda.org" ];
		trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
	};
}