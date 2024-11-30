# Documentation:
#───────────────
# • https://wiki.nixos.org/wiki/Virt-manager
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.11&show=programs.virt-manager.enable
# • https://search.nixos.org/options?channel=24.11&show=users.users.<name>.extraGroups
# • https://search.nixos.org/options?channel=24.11&show=virtualisation.libvirtd.enable

{ config, ... }: {

	# Whether to enable Virt Manager.
	programs.virt-manager.enable = true;

	# User's auxilary groups for accessing libvirtd and using Virt Manager.
	users.users.${config.custom.name}.extraGroups = [ "libvirtd" ];

	# Whether to enable libvirtd, a dameon that manages virtual machines.
	virtualisation.libvirtd.enable = true;

}
