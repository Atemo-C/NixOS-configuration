{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [

		# NVIDIA package.
		linuxPackages.nvidia_x11

		# CUDA package.
#		cudaPackages.cudatoolkit
	];

	hardware = {
		nvidia = {
			# Whether to enable kernel modesetting when using the NVIDIA proprietary driver.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.modesetting.enable
			modesetting.enable = true;

			# Whether to enable nvidia-settings, NVIDIA's GUI configuration tool.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.nvidiaSettings
			nvidiaSettings = true;

			# The NVIDIA driver package to use.
			# See Kernel/Version.nix for the Kernel used in this configuraion.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.package
			package = config.boot.kernelPackages.nvidiaPackages.beta;

			# Whether to enable power management thorugh systemd.
			# https://search.nixos.org/options?channel=24.05&show=hardware.nvidia.powerManagement.enable
			powerManagement.enable = true;
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
