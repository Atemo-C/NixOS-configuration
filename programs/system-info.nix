{ config, lib, ... }: {
	programs = {
		# A monitor of resources.
		btop.install = true;

		# See information on CPU, motherboard and more.
		cpu-x.install = true;

		# Fast system information tool like Neofetch.
		fastfetch.install = true;

		# Tools for reading hardware sensors.
		lm_sensors.install = true;

		# Monitor your CPU, Memory, Disk, Network, and GPU usage graphically.
		mission-center.install = true;

		# Tools for monitoring the health of hard drives.
		smartmontools.install = true;

		# Mersenne prime search / System stability tester (torture).
		mprime.install = true;

		# Provide detailed information on the hardware configuration of the machine.
		lshw.install = true;

		# Vulkan tools and utilities.
		vulkan-tools.install = true;

		# Collection of demos and test programs for OpenGL and Mesa.
		mesa-demos.install = true;

		# Shell abbreviations for BTOP and Fastfetch.
		programs.fish.shellAbbrs = {
			b = lib.mkIf config.programs.btop.install "btop";
			f = lib.mkIf config.programs.fastfetch.install "fastfetch";
		};
	};

	# Link Fastfetch's configuration file.
	systemd.user.tmpfiles.users.${config.userName}.rules = lib.optinoal config.programs.fastfetch.enable
	"L %h/.config/fastfetch/config.jsonc - - - - /etc/nixos/files/fastfetch.jsonc";
}