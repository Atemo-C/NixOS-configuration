{ config, lib, ... }: {
	virtualisation.virtualbox.host = lib.mkIf config.programs.niri.enable rec {
		# Whether to enable VirtualBox.
		enable = true;

		# Whether to install the Oracle Extension Pack for VirualBox.
		enableExtensionsPack = lib.mkIf enable true;
	};

	# Add the user to the `vboxusers` group.
	users.extraGroups.vboxusers.members = lib.optional config.virtualisation.virtualbox.host.enable "${config.userName}";
}