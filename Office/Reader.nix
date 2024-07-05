{ pkgs, ... }: {

	# Document viewer.
	environment.systemPackages = with pkgs; [ cinnamon.xreader ];

}
