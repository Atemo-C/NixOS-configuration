{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Matrix client.
		element-desktop-wayland

		# Revolt client.
		revolt-desktop

		# Discord client.
		unstable.vesktop
	];

}
