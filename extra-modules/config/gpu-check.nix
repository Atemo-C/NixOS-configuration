{ lib, ... }: { options.hardware.activeGpu = lib.mkOption {
	type = lib.types.enum [ "default" "amd" "nvidia-proprietary" ];
	default = "default";
	description = "Select the active GPU driver/configuration for the system. default includes all open-source drivers, and should be used when using Intel graphics or fully open-source NVIDIA GPU drivers.";
}; }