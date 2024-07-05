{ pkgs, ... }: {

	# LibreOffice office suite.
	environment.systemPackages = with pkgs; [ libreoffice-fresh ];

}
