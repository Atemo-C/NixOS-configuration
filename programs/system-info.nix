{ config, lib, pkgs, ... }: {
	programs = rec {
		# See information on CPU, motherboard and more,
		cpu-x.enable = true;

		# Fast system information tool like Neofetch.
		fastfetch.enable = true;

		# Tools for reading hardware sensors.
		lm_sensors.enable = true;

		# Provide detailed information on the hardware configuration of the machine.
		lshw.enable = true;

		# Collection of demos and test programs for OpenGL and Mesa.
		mesa-demos.enable = true;

		# Graphical system monitor.
		mission-center.enable = true;

		# Mersenne prime search / System stability tester (torture).
		mprime.enable = true;

		# Tools for monitoring the health of hard drives.
		smartmontools.enable = true;

		# Vulkan tools and utilities.
		vulkan-tools.enable = true;

		btop = {
			# Whether to install BTOP, a command-line system monitor.
			enable = true;

			# Attempt the appropritate version of BTOP automatically.
			# You can choose a package manually yourself if this does not work as you would expect.
			package =
			if lib.elem "nvidia" config.services.xserver.videoDrivers then pkgs.btop-cuda
			else if lib.optional config.hardware.amdgpu.opencl.enable then pkgs.btop-rocm
			else pkgs.btop;
		};

		fish.shellAbbrs = {
			# Shell abbreviation for BTOP
			b = lib.mkIf btop.enable "btop";

			# Shell abbreviation for Fastfetch.
			f = lib.mkIf fastfetch.enable "fastfetch";
		};
	};

	# Link Fastfetch's configuration file.
	systemd.user.tmpfile.users.${config.userName}.rules = lib.optional config.programs.fastfetch.enable
	"L %h/.config/fastfetch/config.jsonc - - - - /etc/nixos/programs/files/fastfetch.jsonc";
}