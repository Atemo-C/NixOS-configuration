{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases.
		ferium

		# The open-source Java Development Kit, version 23.
		jdk23

		# Infinite-world block sandbox.
		minetest

		# A free, open source launcher for Minecraft.
		prismlauncher
	];

	# List of TCP ports on which incoming connections are accepted.
	# For self-hosted game servers.
	networking.firewall.allowedTCPPorts = [ 69420 ];

}
