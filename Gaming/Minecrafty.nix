{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Mod manager.
		unstable.ferium

		# Minetest.
		unstable.minetest

		# Prism launcher Minecraft launcher.
		unstable.prismlauncher

		# Java.
		jdk
	];

}
