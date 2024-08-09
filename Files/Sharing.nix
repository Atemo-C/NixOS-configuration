{ config, pkgs, ... }: {

	# Linux Mint's Warpinator local file sharing utility.
	environment.systemPackages = with pkgs.unstable; [ warpinator ];

	# Firewall port to open for firesharing.
	networking.firewall.allowedTCPPorts = [
		42000 # Incoming port for transfers.
		42001 # Incoming port for registration.
	];

}
