{ config, pkgs, ... }: {

	# Audio editor.
	environment.systemPackages = with pkgs; [ audacity ];

}
