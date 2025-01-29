{ config, ... }: {

	# List of TCP ports on which incoming SSH connections are accepted.
	networking.firewall.allowedTCPPorts = [ 1263 ];

	services.openssh = {
		# Whether to enable the OpenSSH daemon.
		enable = true;

		# Which ports the SSH daemon should listen to.
		ports = [ 1263 ];

		# OpenSSH settings.
		settings = {
			# Login is allowed only for the listed users:
			AllowUsers = [ "${config.custom.name}" ];

			# Whether the root user can login with SSH.
			PermitRootLogin = "no";
		};

		# Whether to only start an instance for each incoming connection.
		startWhenNeeded = true;
	};

}
