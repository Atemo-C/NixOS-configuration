{ pkgs, ... }: {

	# The one and only.
	environment.systemPackages = with pkgs; [ superTuxKart ];

}
