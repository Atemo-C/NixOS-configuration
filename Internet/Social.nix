{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Matrix client.
		element-desktop

		# Revolt client.
		revolt-desktop

		# Discord client.
		unstable.vesktop
	];

}
