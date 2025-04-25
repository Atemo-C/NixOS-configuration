{ config, ... }: rec {

	services.openssh = {
		# Whether to enable the OpenSSH daemon.
		enable = true;

		# Which ports the SSH daemon should listen to.
		ports = [ 3621 ];

		# OpenSSH settings.
		settings = {
			# Login is allowed only for the listed users.
			AllowUsers = [ "${config.userName}" ];

			# Whether the root user can login with SSH.
			PermitRootLogin = "no";
		};

		# Whether to only start an instance for each incoming connection.
		startWhenNeeded = true;
	};

	# List of TCP ports on which incoming SSH connections are accepted.
	networking.firewall.allowedTCPPorts = services.openssh.ports;

}
