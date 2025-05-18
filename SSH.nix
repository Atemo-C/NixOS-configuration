{ config, lib, ... }: let

	# SSH is toggleable in this module.
	ssh = config.services.openssh.enable;

in rec {

	services.openssh = {
		# Whether to enable the OpenSSH daemon.
		enable = true;

		# Which ports the SSH daemon should listen to.
		ports = lib.optionalAttrs ssh [ 3621 ];

		# OpenSSH settings.
		settings = lib.optionalAttrs ssh {
			# Login is allowed only for the listed users.
			AllowUsers = [ "${config.userName}" ];

			# Whether the root user can login with SSH.
			PermitRootLogin = "no";
		};

		# Whether to only start an instance for each incoming connection.
		startWhenNeeded = lib.optionalAttrs ssh true;
	};

	# Open the desired TCP ports on which incoming SSH connections are accepted.
	networking.firewall.allowedTCPPorts = lib.optionalAttrs ssh services.openssh.ports;

}
