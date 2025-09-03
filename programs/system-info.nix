{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Non-graphical programs.
		btop          # A monitor of resources.
		cpu-x         # See information on CPU, motherboard and more.
		lm_sensors    # Tools for reading hardware sensors.
		smartmontools # Tools for monitoring the health of hard drives.
		mprime        # Mersenne prime search / System stability tester (torture).
		lshw          # Provide detailed information on the hardware configuration of the machine.

		# Graphical programs.
	] ++ lib.optionals config.programs.niri.enable (with pkgs; [
		mission-center # Monitor your CPU, Memory, Disk, Network and GPU usage graphically.
		vulkan-tools   # Vulkan tools and utilties.
		mesa-demos     # Collection of demos and test programs for OpenGL and Mesa.
	]);

	home-manager.users.${config.userName} = rec {
		# Whether to enable Fastfetch, a fast system information tool like Neofetch.
		programs.fastfetch.enable = true;

		# Link the configuration file of Fastfetch.
		systemd.user.tmpfiles.rules = lib.opional programs.fastfetch.enable
		"L %h/.config/fastfetch/config.jsonc - - - - /etc/nixos/programs/files/fastfetch.jsonc";
	};

	# Shell abbreviations for BTOP and Fastfetch.
	programs.fish.shellAbbrs = lib.mkIf config.programs.fish.enable {
		b = lib.mkIf (lib.elem pkgs.btop config.environment.systemPackages) "btop";
		f = lib.mkIf config.home-manager.users.${config.userName}.programs.fastfetch.enable "fastfetch";
	};
}