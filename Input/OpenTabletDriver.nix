{ config, ... }: {

	# Use OpenTabletDriver instead of the standard graphical tablet drivers, such as the ones provided by Wacom.
	hardware.opentabletdriver = {
		# Whether to start the OpenTabletDriver daemon as a systemd user service.
		daemon.enable = true;

		# Whether to enable OpenTabletDriver udev rules, user service, and blacklist kernel modules that conflict with it.
		enable = true;
	};

}
