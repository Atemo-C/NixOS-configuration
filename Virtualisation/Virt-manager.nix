{ config, ... }: {

	# Whether to enable Virt Manager.
	programs.virt-manager.enable = true;

	# User's auxilary groups for accessing libvirtd and using Virt Manager.
	users.users.${config.custom.name}.extraGroups = [ "libvirtd" ];

	# Whether to enable libvirtd, a dameon that manages virtual machines.
	virtualisation.libvirtd.enable = true;

	# Link QEMU firmware to /var/lib/qemu/firmware/.
	systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

}
