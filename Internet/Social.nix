{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Matrix client.
		element-desktop

		# Discord client.
		unstable.vesktop
	];

}
