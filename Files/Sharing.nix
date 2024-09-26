# Documentation:
#───────────────
# • https://github.com/linuxmint/warpinator/blob/master/README.md
#
# Used NixOS options:
#────────────────────
# • https://search.nixos/org/options?channel=24.05&show=networking.firewall.allowedTCPPorts
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
		42000 # Incoming port for Warpinator transfers.
		42001 # Incoming port for Warpinator registrations.
	];

}
