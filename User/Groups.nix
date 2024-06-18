{ config, ... }: {

	users.users.${config.Custom.Name} = {
		# The user's primary group.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.group
		group = "users";

		# The user's auxilary groups. Some groups are present in other modules.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
		extraGroups = [
			"disk"
			"input"
			"plugdev"
			"renderer"
			"storage"
			"video"
			"wheel"
		];
	};

}
