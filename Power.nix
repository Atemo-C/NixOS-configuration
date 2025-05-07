{ config, pkgs, ... }: {

	# Power service & management services.
	services = {
#		tlp = {
#			# Whether to enable the TLP power management daemon.
#			# This is probably not necessary on most modern devices.
#			enable = true;
#
#			# Options passed to TLP.
#			# See https://linrunner.de/tlp for all supported options.
#			settings = {
#				CPU_SCALING_GOVERNOR_ON_AC = "performance";
#				CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
#				CPU_ENERGY_PREF_POLICY_ON_AC = "performance";
#				CPU_ENERGY_PREF_POLICY_ON_BAT = "power";
#				CPU_MIN_PERF_ON_AC = 20;
#				CPU_MIN_PERF_ON_BAT = 0;
#				CPU_MAX_PERF_ON_AC = 100;
#				CPU_MAX_PERF_ON_BAT = 96;
#				START_CHARGE_THRESH_BAT0 = 25;
#				STOP_CHARGE_THRESH_BAT0 = 90;
#			};
#		};

		# Whether to enable the Upower DBus service.
		# It provides power management support to applications.
		upower.enable = true;
	};

#	services.tlp = {
	# Power-related utilities.
	environment.systemPackages = [
		# Read & control device brightness.
		pkgs.brightnessctl

		# Small collection of scripts that handle suspend & resume of behalf of HAL.
		# Here in case `systemctl suspend` does not work, such as computers like Lenovo's ThinkPad L510.
		pkgs.pmutils
	];

	# Alternative suspend commands using `pmutils`; To use if `systemctl supsend` does not work.
#	systemd.services = {
#		"systemd-suspend".serviceConfig.ExecStart = [ "${pkgs.pmutils}/bin/pm-suspend" ];
#		"systemd-hibernate".serviceConfig.ExecStart = [ "${pkgs.pmutils}/bin/pm-hibernate" ];
#		"systemd-hybrid-sleep".serviceConfig.execStart = [ "${pkgs.pmutils}/bin/pm-hybrid-sleep" ];
#	};

}
