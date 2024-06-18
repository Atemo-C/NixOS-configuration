{ conifg, ... }: {

	# User's auxilary groups for accessing Docker.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.users.${config.Custom.Name}.extraGroups = [ "docker" ];

	virtualisation.docker = {

		# Whether to enable Docker.
		# https://search.nixos.org/options?channel=24.05&show=virtualisation.docker.enable
		enable = true;

		rootless = {

			# Wether to enable Docker in a rootless mode.
			# https://search.nixos.org/options?channel=24.05&show=virtualisation.docker.rootless.enable
			enable = true;

			# Point DOCKER_HOST to rootless Docker instance for normal users by default.
			# https://search.nixos.org/options?channel=24.05&show=virtualisation.docker.rootless.setSocketVariable
			setSocketVariable = true;
		};
	};

}
