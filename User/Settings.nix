{ config, ... }: { users.users.${config.userName} = {

	# Short description (title) of the user account, typically the user's full name.
	description = "${config.userTitle}";

	# Extra groups to add the user to.
	extraGroups = [
		"disk"
		"input"
		"plugdev"
		"renderer"
		"storage"
		"video"
		"wheel"
	];

	# The user's "home" directory.
	home = "/User/${config.userTitle}";

	# Initial password for the user.
	# Can and should be changed with the `passwd` command after installation.
	initialPassword = "NeverGonnaGiveYouUp";

	# Set the user as a normal/real user.
	isNormalUser = true;

}; }
