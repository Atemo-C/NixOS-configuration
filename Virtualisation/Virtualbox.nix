{ config, ... }: {

	virtualisation.virtualbox.host = {
		# Whether to enable VirtualBox.
		# https://search.nixos.org/options?channel=24.05&show=virtualisation.virtualbox.host.enable
		enable = true

		# Whether to install the Oracle Extension Pack for VirtualBox.
		# https://search.nixos.org/options?channel=24.05&show=virtualisation.virtualbox.host.enableExtensionPack
		enableExtrensionPack = true;
	};

	# User's auxilary groups for accessing VirtualBox.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.extraGroups.vboxusers.members = [ "${config.Custom.Name}" ];

}
