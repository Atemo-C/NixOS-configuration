{ config, ... }: {
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
		# Polkit authentification using Fuzzel as the menu and cmd-polkit as the backend.
		./fuzzel-polkit-agent.nix

		# Log in to Niri with a nice TUI interface.
		./ly.nix

		# Noctalia desktop shell, providing a bar, notifications, power/program menus, and more.
		./noctalia-shell.nix
	];
}