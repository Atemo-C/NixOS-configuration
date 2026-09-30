{ config, lib, ... }: {
	options.hardware.activeGpu = lib.mkOption {
		type = lib.types.enum [
			"default"
			"amd"
			"nvidia"
		];

		default = "default";

		description = "Select the actve GPU driver/configuration for the system. `default` includes all open-source drivers. `amd` includes AMD-optimized package variants and some support for ROMC. `nvidia` includes support for NVIDIA GPUs, from the 1630 and onward.";
	};

	imports = [ ../../system/nvidia.nix ];
}