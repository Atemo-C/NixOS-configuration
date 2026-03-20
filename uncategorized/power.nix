{ config, lib, ... }: {
	programs = {
		# [C] Show battery status and other ACPI information.
		acpi.enable = true;

		# [C] Read and control device brightness.
		brightnessctl.enable = true;

		# [C] Query and change Linux monitor settings using DDC/CI and USB.
		ddcutil.enable = true;
	};

	services = {
		logind.settings.Login = {
			# Ignore power key actions; Instead letting the user control what it does.
			HandlePowerKey = "ignore";

			# Ignore laptop lid actions; Instead letting the user control what they do.
			HandleLidSwitch = "ignore";
			HandleLidSwitchExternalPower = "ignore";
			HandleLidSwitchDocked = "ignore";
		};

		# D-Bus service for power management.
		upower.enable = true;

		# Makes user-selected power profiles handling available over D-Bus.
		power-profiles-daemon.enable = true;
	};
}