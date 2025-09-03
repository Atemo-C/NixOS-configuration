{ config, lib, ... }: { services.openssh = {
	# Whether to enable the OpenSSH daemon.
	enable = true;

	# Which ports the SSH daemon sohuld listen to.
	ports = [ 0309 ];

	# Login is allowed only for the listed users.
	settings.AllowUsers = [ "${config.userName}" ];

	# Whether the root user can login with SSH.
	settings.PermitRootLogin = "no";

	# Whether to only start an instance for each incoming connection.
	startWhenNeeded = true;
}; }