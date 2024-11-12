# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Docker
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.extraGroups
# • https://search.nixos.org/options?channel=24.05&show=virtualisation.docker.enable
# • https://search.nixos.org/options?channel=24.05&show=virtualisation.docker.rootless.enable
# • https://search.nixos.org/options?channel=24.05&show=virtualisation.docker.rootless.setSocketVariable

{ config, ... }: {

	# User's auxilary groups for accessing Docker.
	users.users.${config.custom.name}.extraGroups = [ "docker" ];

	virtualisation.docker = {
		# Whether to enable Docker.
		enable = true;

		rootless = {
			# Wether to enable Docker in a rootless mode.
			enable = true;

			# Point DOCKER_HOST to rootless Docker instance for normal users by default.
			setSocketVariable = true;
		};
	};

}
