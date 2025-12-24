{ ... }: { hardware.opentabletdriver = {
	# Whether to enable OpenTabletDriver.
	# This automatically replaces the default graphic tablet drivers if conflicting.
	enable = true;

	# Whether to enable OpenTabletDriver systemd integration.
	# This allows it to automatically start with the desktop.
	systemd.enable = true;
}; }