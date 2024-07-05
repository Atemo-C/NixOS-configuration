{ pkgs, ... }: {

	# Email client.
	environment.systemPackages = with pkgs; [ thunderbird ];

}
