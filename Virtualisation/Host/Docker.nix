{ config, pkgs, ... }: rec {

	virtualisation.docker = {
		# Whether to enable Docker.
		enable = true;

		# Whether to start dockerd on boot. Required for --restart=always argument to work.
		enableOnBoot = false;

		rootless = {
			# Wether to enable Docker in a rootless mode.
			enable = true;

			# If using an NVIDIA GPU, enable the CDI feature.
			daemon.settings.features.cdi = config.hardware.nvidia-container-toolkit.enable;

			# Point DOCKER_HOST to rootless Docker instance for normal users by default.
			setSocketVariable = true;
		};
	};

	# If Docker is enabled, add the user to the `docker` group.
	users.users.${config.userName}.extraGroups = if virtualisation.docker.enable then [ "docker" ] else [];

}
