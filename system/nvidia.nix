# All configurations here assume a GTX 1650 or above GPU only.
{ config, lib, ... }: {
	# Specialisation to boot with the fully open-source NVIDIA GPU driver stack.
	# By default, when this module is imported, the system boots with propietary drivers.
	specialisation.nvidia_free.config = {
		hardware.nvidia.gsp.enable = true;
		system.nixos.tags = [ "NVIDIA_free" ];
	};

	# Configuration for the proprietary NVIDIA GPU drivers.
	config = lib.mkIf (! lib.elem "NVIDA_free" config.system.nixos.tags) {
		# Use the proprietary NVIDIA GPU drivers.
		services.xserver.videoDrivers = [ "nvidia" ];

		boot.kernelParams = [
			# Enable resizable BAR support.
			"nvidia.NVreg_EnableResizableBar=1"

			# Skip over zeroing graphics memory buffers at alloc time.
			# https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/modprobe.d/nvidia.conf#L20
			"nvidia.NVreg_InitializeSystemMemoryAllocations=0"

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

		# Add the CUDA binary cache to avoid having to rebuild from source too often.
		# There can be some edge cases where this is not ideal.
		# https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
		nix.settings = {
			substituters = [ "https://cache.nixos-cuda.org" ];
			trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
		};

		# Apply various NVIDIA-specific fixes to various programs.
		# See the issue below as an example of what affected programs can act like otherwise.
		# https://github.com/YaLTeR/niri/issues/1962
		environment.etc = {
			"nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-fix.json".text = builtins.toJSON {
				rules = map (proc: {
					pattern = {
						feature = "procname";
						matches = proc;
					};
					profile = "No VidMem Reuse";
				}) [
					".Discord-wrapped"
					".DiscordCanary-wrapped"
					"electron"
					".electron-wrapped"
					".Hyprland-wrapped"
					"losslesscut"
					"librewolf-wrapped"
					"librewolf"
					"niri"
					"quickshell"
					"quickshell-wrapped"
				];
			};
		};
	};
}