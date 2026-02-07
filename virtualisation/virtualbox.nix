{ config, lib, ... }: {
	virtualisation.virtualbox.host = {
		# Whether to enable VirtualBox.
		enable = true;

		# Whether to install the Oracle Extension Pack for VirualBox.
		enableExtensionsPack = true;
	};

	# Add the user to the `vboxusers` group.
	users.extraGroups.vboxusers.members = lib.optional config.virtualisation.virtualbox.host.enable "${config.userName}";
}