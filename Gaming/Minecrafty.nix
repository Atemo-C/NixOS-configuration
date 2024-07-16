{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Mod manager.
		ferium

		# Prism launcher Minecraft launcher.
		prismlauncher

		# Java.
		jdk
	];

}
