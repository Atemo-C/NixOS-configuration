{ config, lib, ... }: { hardware.opentabletdriver = {
	# Whether to enable OpenTabletDriver, replacing the default graphic tablets drivers when conflicting.
	enable = true;

	# Whether to start the OpenTabletDriver daemon as a systemd user service.
	# It allows for it to auto-start with the desktop.
	daemon.enable = true;
}; }