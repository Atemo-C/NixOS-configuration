# Documentation:
#───────────────
# • https://github.com/linuxmint/warpinator/blob/master/README.md
#
# Used NixOS options:
#────────────────────
# • https://search.nixos/org/options?channel=24.11&show=networking.firewall.allowedTCPPorts
#
# Used NixOS packages:
#─────────────────────
# • [warpinator]
#   https://github.com/linuxmint/warpinator

{ config, pkgs, ... }: {

	# Share files across the LAN.
	environment.systemPackages = [ pkgs.unstable.warpinator ];

	# List of TCP ports on which incoming connections are accepted.
	networking.firewall.allowedTCPPorts = [
		42000
		42001
	];

	# List of UDP ports on which incoming connections are accepted.
	networking.firewall.allowedTCPPorts = [ 5353 ];

}
