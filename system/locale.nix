{ pkgs, ... }: {
	i18n = {
		# Default locale of the system.
		defaultLocale = "en_GB.UTF-8";

		# Extra locale settings for specific elements.
		extraLocaleSettings = rec {
			LC_ADDRESS = "fr_FR.UTF-8";
			LC_IDENTIFICATION = LC_ADDRESS;
			LC_MEASUREMENT = LC_ADDRESS;
			LC_MONETARY = LC_ADDRESS;
			LC_NAME = LC_ADDRESS;
			LC_NUMERIC = LC_ADDRESS;
			LC_PAPER = LC_ADDRESS;
			LC_TELEPHONE = LC_ADDRESS;
			LC_TIME = "en_GB.UTF-8";
		};
	};

	time = {
		# The timezone used when displaying times and dates.
		# See https://wikipedia.org/wiki/List_of_tz_database_time_zones for this setting.
		timeZone = "Europe/Paris";

		# Whether to keep the hardware clock in local time instead of UTC.
		hardwareClockInLocalTime = true;
	};

	# Spell checking dictionaries.
	environment.systemPackages = with pkgs; [
		aspellDicts.en
		aspellDicts.eo
		aspellDicts.fr
		aspellDicts.uk

		hunspellDicts.en_GB-ize
		hunspellDicts.en_US
		hunspellDicts.fr-any
	];
}