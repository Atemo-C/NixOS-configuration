{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Mod manager.
		ferium

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
