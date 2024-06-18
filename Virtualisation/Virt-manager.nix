{ config, ... }: {

	# Whether to enable Virt Manager.
	# https://search.nixos.org/options?channel=24.05&show=programs.virt-manager.enable
	programs.virt-manager.enable = true;

	# User's auxilary groups for accessing libvirtd and using Virt Manager.
	# https://search.nixos.org/options?channel=24.05&show=users.users.%3Cname%3E.extraGroups
	users.users.username.extraGroups = [ "libvirtd" ];

	# Whether to enable libvirtd, a dameon that manages virtual machines.
	# https://search.nixos.org/options?channel=24.05&show=virtualisation.libvirtd.enable
	virtualisation.libvirtd.enable = true;

}
