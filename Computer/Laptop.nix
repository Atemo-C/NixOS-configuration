{ config, ... }: {

	services.tlp = {

		# Whether to enable the TLP power management daemon.
		# https://search.nixos.org/options?channel=24.05&show=services.tlp.enable
		enable = true;

		# Options passed to TLP.
		# https://search.nixos.org/options?channel=24.05&show=services.tlp.settings
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
			CPU_ENERGY_PREF_POLICY_ON_AC = "performance";
			CPU_ENERGY_PREF_POLICY_ON_BAT = "power";
			CPU_MIN_PERF_ON_AC = 0;
			CPU_MIN_PERF_ON_BAT = 0;
			CPU_MAX_PERF_ON_AC = 100;
			CPU_MAX_PERF_ON_BAT = 80;
			START_CHARGE_THRESH_BAT0 = 25;
			STOP_CHARGE_THRESH_BAT0 = 85;
		};
	};

}
