{ config, pkgs, ... }: {

	# Share files across the LAN with Warpinator.
	environment.systemPackages = [ pkgs.unstable.warpinator ];

	# List of TCP and UDP ports on which incoming connections are accepted.
	networking.firewall = {
		allowedTCPPortRanges = [ { from = 42000; to = 42001; } ];
		allowedUDPPorts = [ 5353 ];
	};

}
