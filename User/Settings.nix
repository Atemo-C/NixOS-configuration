{ config, ... }: {

	users.users.${config.Custom.Name} = {

		# Initial password for the user; Can be changed once logged in with the `passwd` command.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.initialPassword
		initialPassword = "NeverGonnaGiveYouUp";

		# This is disabled for more granual control. Read more at the link below.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.isNormalUser
		isNormalUser = true;

		# Short description of the user account, typically the user's full name.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.description
		description = "${config.Custom.Title}";
	};

	# Users that have additional rights when connecting to the Nix daemon.
	# https://search.nixos.org/options?channel=24.05&show=nix.settings.trusted-users
	nix.settings.trusted-users = [ "${config.Custom.Name}" ];

}
