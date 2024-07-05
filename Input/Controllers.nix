{ pkgs, ... }: {

	# Controller testing.
	environment.systemPackages = with pkgs; [ jstest-gtk ];

}
