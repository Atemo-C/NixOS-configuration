# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=nix.settings.trusted-users
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.autoSubUidGidRange
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.createHome
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.description
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.extraGroups
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.group
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.home
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.homeMode
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.initialPassword
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.isNormalUser
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.isSystemUser
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.useDefaultShell

{ config, ... }: {

	# Users that have additional rights when connecting to the Nix daemon.
	nix.settings.trusted-users = [ "${config.custom.name}" ];

	users.users.${config.custom.name} = {
		# Automatically allocate subordinate user and group ids for this user.
		autoSubUidGidRange = true;

		# Whether to create the home directory and ensure ownership as well as permissions to match the user.
		createHome = true;

		# Short description of the user account, typically the user's full name.
		description = "${config.custom.title}";

		# The user's auxilary groups. Some groups are present in other relevant modules.
		extraGroups = [
			"disk"
			"input"
			"plugdev"
			"renderer"
			"storage"
			"video"
			"wheel"
		];

		# The user's primary group.
		group = "users";

		# The user's home directory.
		home = "/User/${config.custom.title}";

		# The user's home directory mode in numeric format.
		homeMode = "755";

		# Initial password for the user; Can be changed once logged in with the `passwd` command.
		initialPassword = "NeverGonnaGiveYouUp";

		# Indicates whether this is an account for a "real" user.
		isNormalUser = true;

		# Indicates whether the user is a system user.
		isSystemUser = false;

		# If true, the user's shell will be set to users.defaultUserShell.
		useDefaultShell = true;
	};

}
