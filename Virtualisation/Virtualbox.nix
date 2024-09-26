# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/VirtualBox
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=virtualisation.virtualbox.host.enable
# • https://search.nixos.org/options?channel=24.05&show=virtualisation.virtualbox.host.enableExtensionPack
# • https://search.nixos.org/options?channel=24.05&show=users.users.<name>.extraGroups

{ config, ... }: {

	virtualisation.virtualbox.host = {
		# Whether to enable VirtualBox.
		enable = true

		# Whether to install the Oracle Extension Pack for VirtualBox.
		enableExtrensionPack = true;
	};

	# User's auxilary groups for accessing VirtualBox.
	users.extraGroups.vboxusers.members = [ "${config.custom.name}" ];

}
