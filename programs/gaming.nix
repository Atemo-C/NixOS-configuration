{ config, lib, pkgs, ... }: {
	environment.systemPackages = lib.optionals config.programs.niri.enable (with pkgs; [
		# Nintendo DS(i) emulator.
		#desmume

		# PlayStation 2 emulator.
		#pcsx2

		# PlayStation 3 emulator.
		#rpcs3

		# XBOX emulator.
		#xemu

		# Java, for Minecraft.
		jdk24

		# CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases.
		ferium

		# Full-featured Minecraft launcher.
		prismlauncher

		# Minecraft Bedrock Launcher.
		mcpelauncher-ui-qt

		# Inifinite-world block sandbox; Previously known as Minetest.
		luanti

		# Native GOG, Epic, and Amazon Games launcher.
		heroic
	]);

	programs = rec {
		gamemode = {
			# Whether to enable GameMode to optimize system performances on demand when gaming.
			enable = true;

			# Disable the screen saver when using gamemode.
			settings.general.inhibit_screensaver = lib.mkIf gamemode.enable 0;
		};

		gamescope = {
			# Whether to enable the Gamescope compositor and session.
			enable = true;

			# Whether to add `cap_sys_nice` capability to GamesScope, so that it may renice itself.
			capSysNice = lib.mkIf gamescope.enable true;
		};

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
			gamescopeSession.enable = lib.mkIf steam.enable true;

			# Whether to open ports in the firewall for Steam Remote Play.
			remotePlay.openFirewall = lib.mkIf steam.enable true;
		};
	};

	# List of TCP ports on which incoming connections are accepted for self-hosted game servers.
	networking.firewall.allowedTCPPorts = [ 42069 ];

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

	# Remove certain resource limits for programs that needs them gone, mostly for heavier emulators.
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