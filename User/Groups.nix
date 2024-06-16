{ config, ... }: {

	# The user's auxilary groups.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.users.username.extraGroups = [
		"disk"
		"input"
		"lp"
		"networkmanager"
		"plugdev"
		"renderer"
		"scanner"
		"storage"
		"users"
		"video"
		"wheel"
	];

}
