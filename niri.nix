{ ... }: {
	programs.niri = {
		# Whether to enable the Niri Wayland compositor.
		enable = true;

		# Whether to enable XWayland support with xwayland-satellite.
		xwayland.enable = true;
	};

	# Link Niri's configuration directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.config/niri/ - - - - /etc/nixos/files/niri/"
	];

	# Import modules that help create a more complete desktop experience.
	imports = [];
}