{ config, lib, ... }: {
	programs = {
		# Show battery status and other ACPI information.
		acpi.install = true;

		# Read and control integrated device brightness.
		brightnessctl.install = true;

		# Query and change Linux monitor settings using DDC/CI and USB.
		ddcutil.install = lib.mkIf config.services.ddccontrol.enable true;
	};

	# whether to enable ddccontrol for controlling displays.
	services.ddccontrol.enable = true;

	# Add the user to the `i2c` group.
	users.users.${config.userName}.extraGroups = lib.optional config.services.ddccontrol.enable "i2c";

	services = {
		logind.settings.Login = {
			# Configure `systemd-logind` to ignore power button actions, letting the user customize them.
			HandlePowerKey = "ignore";

			# For laptops, what to do with different lid actions.
			lidSwitch = "ignore";
			lidSwitchExternalPower = "ignore";
			lidSwitchDocked = "ignore";
		};

		# Whether to enable the Upower DBus service.
		# It provides power management support to applications.
		upower.enable = true;

		# Whether to enable power-profiles-daemon, a DBus daemon that allows
		# changing system behavior based upon user-selected power profiles.
		power-profiles-daemon.enable = true;
	};
}