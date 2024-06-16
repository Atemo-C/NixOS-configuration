{ config, ... }: {

	users.users.username = {

		# The user's primary group.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.group
		group = "users";

		# The user's auxilary groups.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
		extraGroups = [
			"disk"
			"input"
			"lp"
			"networkmanager"
			"plugdev"
			"renderer"
			"scanner"
			"storage"
			"video"
			"wheel"
		];
	};

}
