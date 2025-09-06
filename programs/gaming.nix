{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		#desmume            # Nintendo DS(i) emulator.
		#pcsx2              # PlayStation 2 emulator.
		#rpcs3              # PlayStation 3 emulator.
		#xemu               # XBOX emulator.
		jdk24              # Java, for Minecraft.
		ferium             # CLI program for managing Minecraft mods and modpacks from various sources.
		prismlauncher      # Full-featured Minecraft launcher.
		mcpelauncher-ui-qt # Minecraft Bedrock Launcher.
		luanti             # Inifinite-world block sandbox; Previously known as Minetest.
		heroic             # Native GOG, Epic, and Amazon Games launcher.
		vintagestory       # Indie sandbox game about innovation and exploration.
	]);

	programs = rec {
		# Whether to enable GameMode to optimize system performances on demand when gaming.
		gamemode.enable = true;

		# Disable the screen saver when using gamemode.
		gamemode.settings.general.inhibit_screensaver = lib.mkIf gamemode.enable 0;

		# Whether to enable the Gamescope compositor and session.
		gamescope.enable = true;

		# Whether to add `cap_sys_nice` capabilities to GameScope, so that it may renice itself.
		gamescope.capSysNice = lib.mkIf gamescope.enable true;

		steam = {
			# Whether to enable Steam.
			enable = true;

			# Whether to enable loading the extest library into Steam to translate X11 input events to uinput events.
			# e.g. for using Steam Input on Wayland.
			extest.enable = lib.mkIf steam.enable true;

			# Extra packages to be used as compatibility tools for Steam on Linux.
			extraCompatPackages = lib.optional steam.enable pkgs.proton-ge-bin;

			# Additional packages to add to the Steam environment.
			extraPackages = lib.optional (steam.enable && gamescope.enable) pkgs.gamescope ++
			lib.optional (steam.enable && gamemode.enable) pkgs.gamemode;

			# Whether to enable the GameScope session for Steam.
			gamescopeSession.enable = lib.mkIf (steam.enable && gamescope.enable) true;

			# Whether to open ports in the firewall for Steam Remote Play.
			remotePlay.openFirewall = lib.mkIf steam.enable true;
		};
	};

	boot = {
		# Runtime parameters of the Linux Kernel to enhance gaming performance and to help future-proof.
		kernel.sysctl = {
			"kernel.sched_cfs_bandwidth_slice_us" = 3000;
			"net.ipv4.tcp_fin_timeout" = 5;
			"vm.max_map_count" = 2147483642;
		};

		# Additional kernel parameters to help.
		kernelParams = [ "preempt=full" ];
	};

	# Remove certain resource limits for programs that needs them gone; Mostly for heavier emulators.
	security.pam.loginLimits = [
		{
			domain = "*";
			type = "hard";
			item = "memlock";
			value = "unlimited";
		}
		{
			domain = "*";
			type = "soft";
			item = "memlock";
			value = "unlimited";
		}
	];
}