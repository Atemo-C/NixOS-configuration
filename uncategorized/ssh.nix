{ config, lib, ... }: {
	services.openssh = rec {
		# Whether to enable the OpenSSH daemon.
		enable = true;

		# Which ports the SSH daemon sohuld listen to.
		ports = lib.optional enable 6942;

		# OpenSSH settings.
		settings = lib.mkIf enable {
			# Login is allowed only for the listed users.
			AllowUsers = [ "${config.userName}" ];

			# Whether the root user can login with SSH.
			PermitRootLogin = "no";
		};

		# Whether to only start an instance for each incoming connection.
		startWhenNeeded = lib.mkIf enable true;
	};
}