{ config, pkgs, ... }: {

	# Power utilities.
	environment.systemPackages = with pkgs; [
		# Read and control device brightness.
		brightnessctl

		# Small collection of scripts that handle suspend and resume on behalf of HAL.
		# USeful for systems where `systemctl suspend` does not work properly, such as the ThinkPad L510.
		pmutils
	];

	# Power-saving with TLP.
	services.tlp = {
		# Whether to enable the TLP power management daemon.
		enable = true;

		# Options passed to TLP.
		# See https://linrunner.de/tlp for all supported options.
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
			CPU_ENERGY_PREF_POLICY_ON_AC = "performance";
			CPU_ENERGY_PREF_POLICY_ON_BAT = "power";
			CPU_MIN_PERF_ON_AC = 0;
			CPU_MIN_PERF_ON_BAT = 0;
			CPU_MAX_PERF_ON_AC = 100;
			CPU_MAX_PERF_ON_BAT = 90;
#			START_CHARGE_THRESH_BAT0 = 25;
			STOP_CHARGE_THRESH_BAT0 = 90;
		};
	};

}
