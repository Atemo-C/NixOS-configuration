{ config, pkgs, ... }: {
	# Whether to install the Noctalia shell,
	# a sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell.
	environment.systemPackages = with pkgs; [ noctalia-shell ];

	# Link Noctalia's configuration directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.config/noctalia/ - - - - /etc/nixos/desktop/files/noctalia/"
	];
}