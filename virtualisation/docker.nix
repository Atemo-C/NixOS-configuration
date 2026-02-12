{ config, lib, ... }: { virtualisation.docker = {
	# Whether to enable Docker.
	enable = true;

	# Whether to start dockerd on boot. Required for the `--restart=always` argument to work.
	enableOnBoot = true;

	rootless = rec {
		# Whether to enable Docker in a rootless mode.
		enable = true;

		# If using a compatible NVIDIA GPU, whether to enable the CDI feature.
		daemon.settings.features.cdi = lib.mkIf (enable && config.hardware.nvidia-container-toolkit.enable) true;

		# Whether to point `DOCKER_HOST` to rootless Docker instance for normal users by default.
		setSocketVariable = true;
	};
};}