{ config, ... }: {

	# Which ports the SSH daemon should listen to.
	# https://search.nixos.org/options?channel=24.05&show=services.openssh.ports
	services.openssh.ports = [ ];

	# List of TCP ports on which incoming connections are accepted.
	# https://search.nixos.org/options?channel=24.05&show=networking.firewall.allowedTCPPorts
	networking.firewall.allowedTCPPorts = [ ];

}
