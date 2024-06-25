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

	users.users.${config.Custom.Name} = {
		# Automatically allocate subordinate user and group ids for this user.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.autoSubUidGidRange
		autoSubUidGidRange = true;

		# Whether to create the home directory and ensure ownership as well as permissions to match the user.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.createHome
		createHome = true;

		# Short description of the user account, typically the user's full name.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.description
		description = "${config.Custom.Title}";

		# The user's primary group.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.group
		group = "users";

		# The user's home directory
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.home
		home = "/User/${config.Custom.Title}";

		# The user's home directory mode in numeric format.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.homeMode
		homeMode = "700";

		# Initial password for the user; Can be changed once logged in with the `passwd` command.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.initialPassword
		initialPassword = "NeverGonnaGiveYouUp";

		# Indicates whether this is an account for a "real" user.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.isNormalUser
		isNormalUser = true;

		# Indicates if the user is a system user or not.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.isSystemUser
		isSystemUser = false;

		# If true, the user's shell will be set to users.defaultUserShell.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.useDefaultShell
		useDefaultShell = true;
	};

}
