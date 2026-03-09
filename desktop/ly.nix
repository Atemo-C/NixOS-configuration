{ ... }: { services.displayManager.ly = {
	# Whether to enable the ly display manager.
	enable = true;

	# Whether to enable support for X11 environments.
	x11Support = lib.mkIf config.programs.niri.enable false;
}; }