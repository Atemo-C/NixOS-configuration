{ ... }: {
	# Whether to enable the Niri Wayland compositor.
	programs.niri.enable = true;

	# Link Niri's configuration directory.
	systemd.user.tmpfiles.users.${config.user.name}.rules = [
		"L %h/.config/niri/ - - - - /etc/nixos/files/niri/"
	];

	# Import modules that help create a more complete desktop experience.
	imports = [
		# Log in with a nice TUI interface.
		./ly.nix
	];
}