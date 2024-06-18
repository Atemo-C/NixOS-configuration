{ config, pkgs, ... }: {

	# Kdenlive video editor.
	environment.systemPackages = with pkgs; [ kdePackages.kdenlive ];

}
