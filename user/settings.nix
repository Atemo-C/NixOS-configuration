{ config, ... }: { users.users.${config.userName} = {
	# Short description (title) of the user account, typically the user's full name.
	description = "${config.userTitle}";

	# Extra groups to add the user to.
	extraGroups = [ "disk" "input" "plugdev" "render" "storage" "video" "wheel" ];

	# Set the user as a normal user.
	isNormalUser = true;
}; }