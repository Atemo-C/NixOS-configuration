{ config, ... }: { users.users.${config.custom.name} = {

	# Whether to automatically allocate subordinate user and group IDs for the user.
	autoSubUidGidRange = true;

	# Whether to create the home directory for the user.
	createHome = true;

	# Short description of the user account, typically the user's full name.
	description = "${config.custom.title}";

	# The user's auxilary groups.
	# Some groups are present in other relevant modules.
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

	# The user's home directory mode in numeric fromat.
	homeMode = "755";

	# Initial password for the user.
	# Can be changed with the `passwd` command.
	initialPassword = "NeverGonnaLetYouDown";

	# Whether this is an account for a "real" user.
	isNormalUser = true;

	# Indicates whether the user is a system user.
	isSystemUser = false;

	# Whether the user's shell should be set to users.defaultUserShell.
	useDefaultShell = true;

}; }
