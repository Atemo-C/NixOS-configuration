{ config, lib, ... }: {
	specialisation.nvidia_free.config = {
		hardware.nvidia.gsp.enable = true;
		system.nixos.tags = [ "NVIDIA_free" ];
	};

	config = lib.mkIf (! lib.elem "NVIDA_free" config.system.nixos.tags) {
		services.xserver.videoDrivers = [ "nvidia" ];

		boot.kernelParams = [
			"nvidia.NVreg_EnableResizableBar=1"
			"nvidia.NVreg_InitializeSystemMemoryAllocations=0"
			"nvidia.NVreg_PreserveVideoMemoryAllocations=1"
			"nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1"
			"nvidia.NVreg_UsePageAttributeTable=1"
		];

		hardware = {
			nvidia = {
				open = true;
				powerManagement.enable = true;
			};

			nvidia-container-toolkit.enable = false;
		};

		nix.settings = {
			substituters = [ "https://cache.nixos-cuda.org" ];
			trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
		};

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