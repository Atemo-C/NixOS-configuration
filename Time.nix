{ config, ... }: { time = {

	# The time zone used when displaying times and dates.
	# See https://wikipedia.org/wiki/List_of_tz_database_time_zones for this setting.
	# If null, the timezone will default to UTC and can be set imperatively using timedatectl.
	timeZone = "Europe/Paris";

	# Whether to keep the hardware clock in local time instead of UTC.
	# Mostly useful if dual-booting with a Windows-based operating system.
	hardwareClockInLocalTime = true;

}; }
