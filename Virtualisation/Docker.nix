{ config, pkgs, ... }: {

	# User's auxilary groups for accessing Docker.
	users.users.${config.custom.name}.extraGroups = [ "docker" ];

	virtualisation.docker = {
		# Whether to enable Docker.
		enable = true;

		# Which Docker package to use.
		package = pkgs.unstable.docker;

		rootless = {
			# Wether to enable Docker in a rootless mode.
			enable = true;

			# Point DOCKER_HOST to rootless Docker instance for normal users by default.
			setSocketVariable = true;
		};
	};

}
