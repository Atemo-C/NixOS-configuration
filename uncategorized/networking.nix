{ config, lib, ... }: {
	networking = {
		dhcpcd.wait = "background";
		networkmanager.enable = true;

		stevenblack = {
			enable = true;
			block = [ "fakenews" "gambling" ];
		};
	};

	systemd.services.NetworkManager-wait-online.enable = false;
}