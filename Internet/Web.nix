{ pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Web browser.
		unstable.librewolf

		# TOR web and onion browser.
		tor-browser
	];

}
