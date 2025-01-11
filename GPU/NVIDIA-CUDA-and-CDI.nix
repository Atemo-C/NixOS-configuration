# CUDA packages and CDI for NVIDIA GPUs.
# Some programs, such as Docker, have their own option to enable CDI.
# Check their respective modules.
{ config, pkgs, ... }: {

	# CUDA packages to install, if desired.
	environment.systemPackages = [
		pkgs.unstable.cudaPackages.cudnn
		pkgs.unstable.cudaPackages.cutensor
	];

	# Whether to enable dynamic CDI configuration for NVIDIA GPUs.
	hardware.nvidia-container-toolkit.enable = true;

}
