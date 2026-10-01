# Bridged networking setup.
# Enabled if Virt-Manager is enabled.
{ config, lib, ... }: let
	# Shortcut for the network interface to be used.
	# Replace it with your actual network interface.
	# You can see it with the `ip a` command.
	networkInterface = "enp16s0";
in { networking = rec {
	# Enable the `br0` network bridge over the default network interface.
	bridges."br0".interfaces = lib.optional config.programs.virt-manager.enable "${networkInterface}";

	# Let DHCP configuration be used on the network bridge.
	interfaces = {
		${networkInterface}.useDHCP = lib.mkIf interfaces.br0.useDHCP false;
		br0.useDHCP = true;
	};

	# Unmanage the default network interface when the network bridge is used.
	networkmanager.unmanaged = lib.optional interfaces.br0.useDHCP "${networkInterface}";
}; }