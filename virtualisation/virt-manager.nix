{ config, lib, pkgs, ... }: let virt = config.programs.virt-manager.enable; in {

	# Whether to enable the virt-manager UI for managing libvirt virtual machines.
	programs.virt-manager.enable = true;

	virtualisation.libvirtd = {
		# Whether to enable the libvirtd daemon to manage virtual machines.
		enable = lib.mkIf virt true;

		# vhost-user virtio-fs device backend.
		qemu.vhostUserPackages = lib.optional virt pkgs.virtiofsd;
	};

	# Bridged networking setup.
	# BE CAREFUL! Change `enp16s0` to YOUR primary network interface.
	# You can see it with `ip a`.
	networking = lib.mkIf virt {
		bridges."br0".interfaces = [ "enp16s0" ];

		interfaces = {
			enp16s0.useDHCP = true;
			br0.useDHCP = true;
		};
	};

	# Add the user to the `libvirtd` group.
	users.users.${config.user.name}.extraGroups = lib.optional virt "libvirtd";
}