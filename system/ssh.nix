{ config, ... }: { services.openssh = {
	# Whether to enable the OpenSSH secure shell daemon.
	enable = true;

	# Which ports the SSH daemon should listen to.
	ports = [ 4096 ];

	settings = {
		# If specified, login is allowed only for the listed users.
		AllowUsers = [ "${config.user.name}" ];

		# Whether to permit root login through SSH.
		PermitRootLogin = "no";
	};

	# Whether to start an instance for each incoming connection.
	startWhenNeeded = true;
}; }