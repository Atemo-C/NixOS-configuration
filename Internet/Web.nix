{ config, pkgs, ... }: {

	environment.systemPackages = with pkgs; [
		# Web browser.
		librewolf

		# TOR web and onion browser.
		tor-browser-bundle-bin
	];

}
