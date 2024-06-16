{ config, ... }: {

	users.users.username = {

		# Whether to create the home directory and manage necessary permissions.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.createHome
		createHome = true;

		# The user's home directory.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.home
		home = "/Path/To/Directory";

		# If true, the user's shell will be set to `users.defaultUserShell`.
		# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.useDefaultShell
		useDefaultShell = true;
	};

	# Users that have additional rights when connecting to the Nix daemon.
	# https://search.nixos.org/options?channel=24.05&show=nix.settings.trusted-users
	nix.settings.trusted-users = [ "username" ];

}
