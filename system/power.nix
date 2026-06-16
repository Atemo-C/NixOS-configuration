{ config, lib, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Show battery status and other ACPI information.
		acpi

		# Read and control device brightness.
		brightnessctl
	] ++
		# Query and change Linux monitor settings using DDC/CI and USB.
		lib.optional config.services.ddccontrol.enable pkgs.ddcutil;

	services = {
		# Whether to enable ddccontrol for controlling displays.
		ddccontrol.enable = true;

		# Let the user's environment handle power keys actions.
		logind.settings.Login = {
			HandlePowerKey = "ignore";
			HandleLidSwitch = "ignore";
			HandleLidSwitchExternalPower = "ignore";
			HandleLidSwitchDocked = "ignore";
		};

		# Whether to enable the Upower DBus service,
		# providing power management support to applications.
		upower.enable = true;

		# Whether to enable the power-profiles-daemon,
		# a DBus daemon that allows changing system behavior
		# based upon user-selected power profiles.
		power-profiles-daemon.enable = true;
	};

	# Add the user to the `i2c` group.
	users.users.${config.user.name}.extraGroups = lib.optional config.services.ddccontrol.enable "i2c";
}