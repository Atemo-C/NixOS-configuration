{ config, ... }: {

	services.openssh = {
		# Whether to enable the OpenSSH daemon.
		# https://search.nixos.org/options?channel=24.05&show=services.openssh.enable
		enable = true;

		# Only start an instance for each incoming connection.
		# https://search.nixos.org/options?channel=24.05&show=services.openssh.startWhenNeeded
		startWhenNeeded = true;
	};

}
