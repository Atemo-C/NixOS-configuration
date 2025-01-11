{ config, pkgs, ... }: {

	environment.systemPackages = [
		# CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases.
		pkgs.unstable.ferium

		# The open-source Java Development Kit, version 23.
		pkgs.jdk23

		# Infinite-world block sandbox.
		pkgs.unstable.minetest

		# A free, open source launcher for Minecraft.
		pkgs.unstable.prismlauncher
	];

	# List of TCP ports on which incoming connections are accepted.
	# For self-hosted game servers.
	networking.firewall.allowedTCPPorts = [ 69420 ];

}
