{ config, ... }: {

	services.openssh.settings = {
		# Login is allowed only for the listed users.
		# https://search.nixos.org/options?channel=24.05&show=services.openssh.settings.AllowUsers
		AllowUsers = [ "${config.Custom.Name}" ];

		# Whether the root user can login using ssh.
		# https://search.nixos.org/options?channel=24.05&show=services.openssh.settings.PermitRootLogin
		PermitRootLogin = "no";
	};

}
