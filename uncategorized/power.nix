{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Show battery status and other ACPI information.
		acpi

		# Read and control integrated device brightness.
		brightnessctl

		# Query and change Linux montor settings using DDC/CI and USB.
		ddcutil
	];

	# Whether to enable i2c devices support.
	hardware.i2c.enable = true;

	services = {
		logind = {
			# Configure `systemd-logind` to ignore power button actions, letting the user customize them.
			settings.logind.HandlePowerKey = "ignore";

			# For laptops, what to do with different lid actions.
			lidSwitch = "suspend";
			lidSwitchExternalPower = "suspend";
			lidSwitchDocked = "ignore";
		};

		# Whether to enable the Upower DBus service.
		# It provides power management support to applications.
		upower.enable = true;
	};
}