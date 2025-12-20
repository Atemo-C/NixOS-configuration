{ config, lib, ... }: {
	# Use the proprietary NVIDIA drivers for 1650 and later GPUs.
	services.xserver.videoDrivers = [ "nvidia" ];

	# NVIDIA driver settings to apply from boot.
	boot.kernelParams = lib.optionals (lib.elem "nvidia" config.services.xserver.videoDrivers) [
		# Enable support for resizeable BAR.
		"nvidia.NVreg_EnableResizableBar=1"

		# Skip over zeroing graphics memory buffers at alloc time.
		# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/nvidia.conf#L20
		"nvidia.NVreg_InitializeSystemMemoryAllocations=0"

		# Make resuming more stable.
		"nvidia.NVreg_PreserveVideoMemoryAllocations=1"

		# Lower latency when gaming. If causing issues, disable it.
		"nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1"

		# Fixes poor CPU performances in a lot of cases.
		"nvidia.NVreg_UsePageAttributeTable=1"

		# Store temporary files on disk and not on ram (/tmp).
		#"nvidia.NVreg_TemporaryFilePath=/var/tmp"
	];

	hardware = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		nvidia = {
			# Whether to enable the open-source NVIDIA kernel modules.
			# Recommended for 560+ drivers; Necessary for RTX 50 series and above GPUs.
			open = true;

			# The driver package to use.
			nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable power management through systemd.
			# This is often necessary to make suspending more stable.
			powerManagement.enable = true;
		};

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
		nvidia-container-toolkit.enable = false;
	};

	# Apply some extra udev rules for NVIDIA GPUs.
	# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/udev/rules.d/71-nvidia.rules
	services.udev.extraRules = lib.optionalString (lib.elem "nvidia" config.services.xserver.videoDrivers) ''
		ACTION=="add|bind", SUBSYSTEM=="pci", DRIVERS=="nvidia", \
			ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
			TEST=="power/control", ATTR{power/control}="auto"

		ACTION=="remove|unbind", SUBSYSTEM=="pci", DRIVERS=="nvidia", \
			ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
			TEST=="power/control", ATTR{power/control}="on"
	'';

	# CUDA packages to install.
	programs = lib.mkIf (lib.elem "nvidia" config.services.xserver.videoDrivers) {
		# Deep Neural Network library.
		cudnn.enable = true;

		# Wrapper substituting the deprecated runfile-based CUDA installation.
		cudatoolkit.enable = true;

		# High-performance CUDA library for Tensor Primitives.
		libcutensor.enable = true;
	};
}