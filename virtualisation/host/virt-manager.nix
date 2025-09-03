{ config, lib, ... }: {
	# Whether to enable libvirtd, a daemon that manages virtual machines.
	virtualisation.libvirtd.enable = true;

	# Add the user to the `libvirtd` group.
	users.users.${config.userName}.extraGroups = lib.optional config.virtualisation.libvirtd.enable "libvirtd";

	# Whether to enable the Virt Manager virtual machine manager.
	programs.virt-manager.enable = lib.mkIf (config.virtualisation.libvirtd.enable && config.programs.niri.enable) true;
}