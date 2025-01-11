{ config, ... }: {

	# Use OpenTabletDriver instead of the standard graphical tablet drivers, such as the ones provided by Wacom.
	hardware.opentabletdriver = {
		# Whether to start OpenTabletDriver daemon as a systemd user service.
		daemon.enable = true;

		# Enable OpenTabletDriver udev rules, user service and blacklist kernel modules that conflict with it.
		enable = true;
	};

	# Starts the OpenTabletDriver dameon when the Hyprland Wayland compositor is started.
	home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings.exec-once = [ "otd-dameon" ];

}
