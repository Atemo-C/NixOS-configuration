# All configuration options here assume an NVIDIA GTX 1630 or above only.
{ config, lib, pkgs, ... }: {
	# Specialisation for booting with the fully open-source driver stack.
	# The proprietary drivers remain the default option otherwise.
	specialisation.nvidia_open.config = {
		# Whether to enable the GPU System Processor (GSP).
		hardware.nvidia.gsp.enable = true;

		# Tag for the specialisation.
		system.nixos.tags = [ "nvidia_open" ];
	};

	# Apply the following configuration to the normal system.
	config = lib.mkIf (config.specialisation != {}) {
		# Use the proprietary NVIDIA drivers.
		services.xserver.videoDrivers = [ "nvidia" ];

		# NVIDIA driver settings to apply from boot.
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
				# Whether to enable the open-source NVIDIA kernel modules.
				# Unless you somehow use a driver version below 560, keep this to `true`.
				open = true;

				# Whether to enable power management through systemd.
				# This can be necessary for stable suspend with the proprietary drivers.
				powerManagement.enable = true;
			};

			# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
			nvidia-container-toolkit.enable = false;
		};

		# CUDA packages to install.
		environment.systemPackages =
		lib.optionals config.hardware.nvidia-container-toolkit.enable (with pkgs.cudaPackages; [
			cudnn
			libcutensor
			cudatoolkit
		]);

		# Apply some extra udev rules from CachyOS.
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

			"nvidia/nvidia-application-profiles-rc.d/60-librewolf-firefox.json".text = ''
				{
					"rules": [{
						"pattern": ".librewolf-wrapped",
						"profile": "ForceSeparateTrimThread",

						"pattern": ".librewolf-wrapped",
						"profile": "FA0",

						"pattern": ".librewolf-wrapped",
						"profile": "DedicatedHwStatePerCtx"
					}]
				}
			'';
		};
	};
}