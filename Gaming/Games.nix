# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=networking.firewall.allowedTCPPorts
#
# Used NixOS packages:
#─────────────────────
# • [ferium]
#   https://github.com/gorilla-devs/ferium
#
# • [jdk]
#   https://openjdk.java.net/
#
# • [minetest]
#   https://minetest.net/
#
# • [prismlauncher]
#   https://prismlauncher.org/

{ config, pkgs, ... }: {

	environment.systemPackages = [
		# CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases.
		pkgs.unstable.ferium

		# The open-source Java Development Kit, version 22.
		pkgs.jdk23

		# Infinite-world block sandbox.
		pkgs.unstable.minetest

		# A free, open source launcher for Minecraft.
		pkgs.unstable.prismlauncher
	];

	# List of TCP ports on which incoming connections are accepted for self-hosted game servers.
	networking.firewall.allowedTCPPorts = [];

}
