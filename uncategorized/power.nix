{ config, pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		# Show battery status and other ACPI information.
		acpi

		# Read and control device brightness.
		brightnessctl
	];

	services = {
		# Configure `systemd-logind` to ignore power button actions, letting the user customize them.
		logind.extraConfig = ''HandlePowerKey=ignore'';

		# Whether to enable the Upower DBus service.
		# It provides power management support to applications.
		upower.enable = true;
	};
}