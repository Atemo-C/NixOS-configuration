{ pkgs, ... }: {

	# Scanning utility
	environment.systemPackages = with pkgs; [ gnome.simple-scan ];

}
