{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Nintendo DS emulator.
		desmume

		# Fast and multi-source CLI program for managing Minecraft mods and modpacks,
		# from sources like Modrinth, CurseForge, and GitHub Releases.
		ferium

		# Native GOG, Epic, and Amazon Games Launcher.
#		heroic

		# Modern GBA emulator with a focus on accuracy.
		mgba

		# Free, open source launcher for Minecraft.
		prismlauncher

		# PlayStation 2 emulator.
		pcsx2

		# PlayStation 3 emulator.
		rpcs3

		# Rosalie's Mupen GUI (Nintendo64 emulator).
		rmg-wayland

		# Original Xbox emulator.
		xemu

		# In-development indie sandbox game about innovation and exploration.
		vintagestory
	];

	programs.steam = {
		# Whether to perpetuate the cycle of the modern PC gamer.
		enable = true;

		# Whether to load the extest library into Steam,
		# to translate X11 input events to uinput events
		# (e.g. for using Steam Input on Wayland).
		extest.enable = true;

		# Add ProtonGE to Steam.
		extraCompatPackages = [ pkgs.proton-ge-bin ];

		# Whether to open pors in the firewall for Steam Local Network Game Transfers.
		localNetworkGameTransfers.openFirewall = true;

		# Whether to open ports in the firewall for Steam Remote Play.
		remotePlay.openFirewall = true;
	};

	networking.firewall = lib.mkIf (lib.elem pkgs.vintagestory config.environment.systemPackages) {
		# Open ports in the firewall for local and remote game discovery in Vintage Story.
		# • LAN only = 42420 TCP/UDP
		# • Lan + Global = 42420 TCP/UDP + 1900 UDP
		allowedTCPPorts = [ 42420 ];
		allowedUDPPorts = [ 42420 1900 ];
	};

	# Unlock certain limits to make RPCS3 work properly.
	security.pam.loginLimits = lib.mkIf (lib.elem pkgs.rpcs3 config.environment.systemPackages) [
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