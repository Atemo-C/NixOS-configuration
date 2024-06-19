{ config, pkgs, ... }: {

	# Xclicker autoclicker (for Xwayland programs/games).
	environment.systemPackages = with pkgs; [ xclicker ];

}
