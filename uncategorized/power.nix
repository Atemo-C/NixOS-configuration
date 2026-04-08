{ config, lib, ... }: {
	programs = {
		acpi.enable = true;
		brightnessctl.enable = true;
		ddcutil.enable = true;
	};

	services = {
		logind.settings.Login = {
			HandlePowerKey = "ignore";
			HandleLidSwitch = "ignore";
			HandleLidSwitchExternalPower = "ignore";
			HandleLidSwitchDocked = "ignore";
		};

		upower.enable = true;
		power-profiles-daemon.enable = true;
	};
}