# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Nvidia
# • https://nixos.org/manual/nixos/stable/#sec-x11-graphics-cards-nvidia
# • https://wiki.hyprland.org/Nvidia/
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=boot.kernelParams
# • https://search.nixos.org/options?channel=24.11&show=hardware.nvidia.modesetting.enable
# • https://search.nixos.org/options?channel=24.11&show=hardware.nvidia.open
# • https://search.nixos.org/options?channel=24.11&show=hardware.nvidia.package
# • https://search.nixos.org/options?channel=24.11&show=hardware.nvidia.powerManagement.enable
# • https://search.nixos.org/options?channel=24.11&show=hardware.nvidia-container-toolkit.enable
# • https://search.nixos.org/options?channel=24.11&show=services.xserver.videoDrivers
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings

{ config, pkgs, ... }: {

	# Parameters added to the kernel command line.
	boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

	# List of CUDA packages to install.
#	environment.systemPackages = [
#		pkgs.unstable.cudaPackages.cudnn
#		pkgs.unstable.cudaPackages.cutensor
#	];

	hardware = {
		nvidia = {
			# Whether to enable kernel modesetting when using the NVIDIA proprietary driver.
			modesetting.enable = true;

			# Whether to enable the open source NVIDIA kernel module.
			open = true;

			# The NVIDIA driver package to use.
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable experimental power management through systemd.
			powerManagement.enable = true;
		};

		# Whether to enable dynamic CDI configuration for NVIDIA GPUs by running nvidia-container-toolkit on boot.
		nvidia-container-toolkit.enable = false;
	};

	# Environment variables for Hyprland.
	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.env = [
		"LIBVA_DRIVER_NAME, nvidia"
		"XDG_SESSION_TYPE,wayland"
		"GBM_BACKEND,nvidia-drm"
		"__GLX_VENDOR_LIBRARY_NAME,nvidia"
		"NVD_BACKEND,direct"
	];

	# Names of the video drivers to be supported.
	services.xserver.videoDrivers = [ "nvidia" ];

}
