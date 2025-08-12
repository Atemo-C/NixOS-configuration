{ config, lib, ... }: {
	hardware.opentabletdriver = lib.mkIf config.programs.niri.enable rec {
		# Whether to enable OpenTabletDriver, replacing the default drivers when conflicting.
		enable = true;

		# Whether to start the OpenTabletDriver daemon as a systemd user service.
		# It allows for it to start with the desktop.
		daemon.enable = lib.mkIf enable true;
	};
}