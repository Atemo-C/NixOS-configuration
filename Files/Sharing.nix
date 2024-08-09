{ pkgs, ... }: {

	# Linux Mint's Warpinator local file sharing utility.
	environment.systemPackages = with pkgs.unstable; [ warpinator ];

}
