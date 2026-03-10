{ ... }: {
	# Whether to enable the Niri Wayland compositor.
	# XWayland support is enabled by default. You can disable it with the following optiop:
	# programs.niri.xwaylandSupport = false;
	programs.niri.enable = true;

	# Link Niri's configuration directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.config/niri/ - - - - /etc/nixos/desktop/files/niri/"
	];

	# Import modules that help create a more complete desktop experience.
	imports = [
		# Log in with a nice TUI interface.
		./ly.nix
	];
}