{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# A monitor of resources.
		btop

		# Tools for reading hardware sensors.
		lm_sensors

		# Tools for monitoring the health of hard drives.
		smartmontools

		# Mersenne prime search / System stability tester (torture).
		mprime

		# Provide detailed information on the hardware configuration of the machine.
		lshw
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		# See information on CPU, motherboard and more.
		cpu-x

		# Monitor your CPU, Memory, Disk, Network and GPU usage graphically.
		mission-center

		# Vulkan tools and utilties.
		vulkan-tools

		# Collection of demos and test programs for OpenGL and Mesa.
		mesa-demos
	]);

	home-manager.users.${config.userName} = {
		# Whether to enable Fastfetch, a fast system information tool like Neofetch.
		programs.fastfetch.enable = true;

		# Link the configuration file to the right place.
		systemd.user.tmpfiles.rules = lib.optional config.home-manager.users.${config.userName}.programs.fastfetch.enable
			"L %h/.config/fastfetch/config.jsonc - - - - /etc/nixos/programs/files/fastfetch.jsonc";
	};

	# Shell abbreviations for BTOP and Fastfetch.
	programs.fish.shellAbbrs = lib.mkIf config.programs.fish.enable {
		b = lib.mkIf (lib.elem pkgs.btop config.environment.systemPackages) "btop";
		f = lib.mkIf config.home-manager.users.${config.userName}.programs.fastfetch.enable "fastfetch";
	};
}