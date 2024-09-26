# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=networking.firewall.allowedTCPPorts
# • https://search.nixos.org/options?channel=24.05&show=services.openssh.enable
# • https://search.nixos.org/options?channel=24.05&show=services.openssh.ports
# • https://search.nixos.org/options?channel=24.05&show=services.openssh.settings.AllowUsers
# • https://search.nixos.org/options?channel=24.05&show=services.openssh.settings.PermitRootLogin
# • https://search.nixos.org/options?channel=24.05&show=services.openssh.startWhenNeeded

{ config, ... }: {

	# List of TCP ports on which incoming SSH connections are accepted.
	networking.firewall.allowedTCPPorts = [ 2077 ];

	services.openssh = {
		# Whether to enable the OpenSSH daemon.
		enable = true;

		# Which ports the SSH daemon should listen to.
		ports = [ 2077 ];

		settings = {
			# Login is allowed only for the listed users.
			AllowUsers = [ "${config.custom.name}" ];

			# Whether the root user can login using ssh.
			PermitRootLogin = "no";
		};

		# Only start an instance for each incoming connection.
		startWhenNeeded = true;
	};

}
