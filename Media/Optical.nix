{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# XFCE's disc burner and project creator.
		xfce.xfburn

		# Bunch of CD/DVD utilities.
		cdparanoia
		cdrdao
		cdrtools
		dvdplusrwtools
		transcode
		vcdimager
	];

}
