{ config, lib, ... }: { virtualisation.docker = {
	# Enable the Docker daemon.
	enable = true;

	# Start dockerd on boot. Required for the `--restart=always` argument to work.
	enableOnBoot = true;

	rootless = rec {
		# Enable Docker in a rootless mode.
		enable = true;

		# If using a compatible NVIDIA GPU with proprietary drivers, enable the CDI feature.
		daemon.settings.features.cdi = lib.mkIf (enable && config.hardware.nvidia-container-toolkit.enable) true;

		# Point `DOCKER_HOST` to rootless Docker instance for normal users by default.
		setSocketVariable = true;
	};
};}