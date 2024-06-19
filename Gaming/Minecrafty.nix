{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Prism launcher Minecraft launcher.
		prismlauncher

		# Minecraft Classic client written from scratch in C.
		classicube

		# Infinite-world block sandbox game.
		minetest

		# Java.
		jdk
	];

}
