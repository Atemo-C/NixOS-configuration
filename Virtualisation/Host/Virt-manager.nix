{ config, lib, pkgs, ... }: rec {

	# Whether to enable libvirtd, a dameon that manages virtual machines.
	virtualisation.libvirtd.enable = true;

	# Whether to enable Virt Manager.
	programs.virt-manager.enable = virtualisation.libvirtd.enable;

	# If libvirtd is enabled, add the user to the `libvirtd` group.
	users.users.${config.userName}.extraGroups = lib.optionalAttrs virtualisation.libvirtd.enable [ "libvirtd" ];

	# If libvirtd is enabled, link some QEMU files to /var/lib/qemu/firmware/.
	systemd.tmpfiles.rules = lib.optionalAttrs virtualisation.libvirtd.enable
		[ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

}
