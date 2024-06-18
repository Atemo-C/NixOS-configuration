{ config, ... }: {

	users.users.username = {

		# Initial password for the user; Can be changed once logged in with the `passwd` command.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.initialPassword
		initialPassword = "GetRickRolled";

		# This is disabled for more granual control. Read more at the link below.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.isNormalUser
		isNormalUser = true;
	};

	# Users that have additional rights when connecting to the Nix daemon.
	# https://search.nixos.org/options?channel=24.05&show=nix.settings.trusted-users
	nix.settings.trusted-users = [ "username" ];

}
