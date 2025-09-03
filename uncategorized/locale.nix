{ ... }: {
	# Default language of the system.
	i18n.defaultLocale = "en_US.UTF-8";

	# Additional locale settings other than the language.
	i18n.extraLocaleSettings = rec {
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

	# The time zone used when displaying times and dates.
	# See https://wikipedia.org/wiki/List_of_tz_database_time_zones for this setting.
	# If null, the timezone will default to UTC and can be set imperatively using timedatectl.
	time.timeZone = "Europe/Paris";

	# Whether to keep the hardware clock in local time instead of UTC.
	# Mostly useful if dual-booting with a Windows-based operating system.
	time.hardwareClockInLocalTime = true;
}