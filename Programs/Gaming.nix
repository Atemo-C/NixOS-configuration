{ config, pkgs, ... }: let

	gamescope = config.programs.gamescope.enable;
	gamemode  = config.programs.gamemode.enable;
	steam     = config.programs.steam.enable;

in {

	# Games, emulators, and other relevant packages to install.
	environment.systemPackages = [
		# An open-source Nintendo DS emulator.
		pkgs.desmume

		# PlayStation 1 emulator.
		pkgs.duckstation

		# PlayStation 2 emulator.
		pkgs.pcsx2

		# PlayStation emulator.
#		pkgs.rpcs3

		# CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases.
		pkgs.ferium

		# The open-source Java Development Kit, version 23.
		pkgs.jdk23

		# Minecraft Bedrock launcher.
		pkgs.mcpelauncher-ui-qt

		# Infinite-world block sandbox.
		pkgs.minetest

		# A free, open source launcher for Minecraft.
		pkgs.prismlauncher
	];

	programs = {
		gamemode = {
			# Whether to enable GameMode to optimise system performance on demand for gaming.
			enable = true;

			# System-wide configuration for GameMode (/etc/gamemode.ini).
			settings.general = if gamemode then { inhibit_screensaver = 0; } else {};
		};

		# Whether to enable Gamescope, the SteamOS session compositing window manager.
		gamescope.enable = true;

		steam = {
			# Whether to enable Steam.
			enable = true;

			# Enable loading the extest library into Steam, to translate X11 input events to uinput events.
			# (e.g. for using Steam Input on Wayland).
			extest.enable = steam;

			# Extra packages to be used as compatibility tools for Steam on Linux.
			extraCompatPackages = if steam then [ pkgs.proton-ge-bin ] else [];

			# Additional packages to add to the Steam environment.
			extraPackages = if steam && gamescope then [
				# SteamOS session compositing window manager.
				pkgs.gamescope
			] else [] ++ (
				if steam && gamemode then [
					# Optimise Linux system performance for gaming on demand.
					pkgs.gamemode
				] else []
			);

			# Whether to open ports in the firewall for Steam Retome Play.
			remotePlay.openFirewall = steam;
		};
	};

	# List of TCP ports on which incoming connections are accepted.
	# For self-hosted game servers.
	networking.firewall.allowedTCPPorts = [ 69420 ];

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

	# Use an alternative kernel thread scheduler for better performance in some games.
	# Can also provide a slightly smoother system when the CPU is being absolutely cooked 🍳.
	services.scx = {
		enable = true;
		scheduler = "scx_lavd";
	};


}
