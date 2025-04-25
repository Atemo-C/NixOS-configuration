{ config, ... }: {

	virtualisation.virtualbox.host = {
		# Whether to enable VirtualBox.
		enable = true

		# Whether to install the Oracle Extension Pack for VirtualBox.
		enableExtrensionPack = true;
	};

	# User's auxilary groups for accessing VirtualBox.
	users.extraGroups.vboxusers.members = [ "${config.userName}" ];

}
